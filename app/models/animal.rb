# == Schema Information
#
# Table name: animals
#
#  id             :integer          not null, primary key
#  animal_type    :string(255)
#  name           :string(255)
#  breed          :string(255)
#  weight         :integer
#  photo          :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  ranch_id       :integer
#  butcher_id     :integer
#  cow_mult       :float
#  pig_mult       :float
#  lamb_mult      :float
#  goat_mult      :float
#  host_id        :integer
#  final_sale     :boolean          default(FALSE)
#  opening_sale   :boolean          default(TRUE)
#  open           :boolean          default(TRUE)
#  finalized      :boolean          default(FALSE)
#  hanging_weight :float
#  meat_weight    :float
#  no_sales       :boolean          default(FALSE)
#

class Animal < ActiveRecord::Base
  attr_accessible :breed, :name, :photo, :animal_type, :hanging_weight, :meat_weight,  
                  :weight, :ranch_id, :butcher_id, :cow_mult, :pig_mult, :packages_attributes,
                  :lamb_mult, :goat_mult, :host_id, :final_sale, :opening_sale, :open, :no_sales
  has_many :orders
  has_many :packages
  has_many :lines, through: :orders
  belongs_to :butcher
  belongs_to :ranch
  belongs_to :host
  
  after_create do 
    if !Rails.env.test
      create_packages
      start_opening_sale
    end
  end

  accepts_nested_attributes_for :packages

  validates :weight, presence: true
  validates :breed, presence: true
  validates :animal_type, presence: true
 
  def sold
    packages.sold
  end

  def unsold
    packages.unsold
  end

  def cutlist
    Cut.where(animal_type: animal_type).weighted
  end

  def create_packages
  	cutlist.each{ |cut| create_cut_packages(cut) }
  end

  def package_price(cut)
    cut.incentive ? cut.price * 0.9 : cut.price
  end

  def create_cut_packages(cut)
    cut.number_of_packages_for_animal(weight).times do 
      create_package_for_cut(cut)
    end
  end

  def create_package_for_cut(cut)
    Package.create!(
      animal_id: id,
      cut_id: cut.id,
      price: cut.package_price,
      sold: false,
      savings: cut.savings
    )
  end

  def cut_find
	 Cut.where(:animal_type => animal_type)
  end

  def pounds_total
    packages.map(&:expected_weight).inject(:+)
  end

  def pounds_sold
    packages.sold.map(&:expected_weight).inject(:+)
  end

  def pounds_left
    pounds_total - pounds_sold
  end 


  def percent_left
    (100 * pounds_left) / pounds_total
  end  

  def start_opening_sale
    if !no_sales && opening_sale
      delay(:run_at => 120.minutes.from_now).end_opening_sale
    end
  end

  def end_opening_sale
    if opening_sale
      unsold.select{ |p| p.cut.incentive }.each do |p|
        p.update_attribute(:price, p.price / 0.9)
        p.update_attribute(:savings, (p.cut.comp - p.price)/p.cut.comp)
      end
      update_attribute(:opening_sale, false)
    end
  end

  def start_final_sale
    unless no_sales
      end_opening_sale
      unsold.each do |p|
        p.update_attribute(:price, (p.price * 0.85))
        p.update_attribute(:savings, (p.cut.comp - p.price)/p.cut.comp)
      end
      update_attribute(:final_sale, true)
    end
  end

  def cut_packages(cut)
    Package.where(:animal_id => id).where(:cut_id => cut.id)
  end

  def sold(cut)
    cut_packages(cut).where(:sold => true)
  end

  def cut_unsold(cut)
    cut_packages(cut).where(:sold => false)
  end

  def revenue_made
    packages.sold.map(&:revenue).inject(:+) || 0
  end

  def revenue_possible
    packages.map(&:expected_revenue).inject(:+)
  end

  def left_to_make
    revenue_possible - revenue_made
  end

  # Returns total cost (for meat, butchery, and fixed, for the given animal)
  
  def meat_price
    ranch.send("#{animal_type.downcase}_meat".to_sym)
  end

  def hanging_price
    ranch.send("#{animal_type.downcase}_hanging".to_sym)
  end

  def live_price
    ranch.send("#{animal_type.downcase}_live".to_sym)
  end

  def weight_ratio(first, second)
    constant = "#{animal_type[0].capitalize}#{first[0].capitalize}O#{second[0].capitalize}"
    return constant.constantize
  end

  def fixed_price
    ranch_fixed = ranch.send("#{animal_type.downcase}_fixed".to_sym)
    ranch_fixed ? ranch_fixed : 0
  end

  def butcher_final_price
    butcher.final_price ? butcher.final_price : 0
  end

  def raw_animal_price
    if meat_price > 0
      meat_price * weight_ratio("meat", "live") * weight
    elsif hanging_price > 0
      hanging_price * weight_ratio("hanging", "live") * weight
    else
      live_price * weight
    end
  end

  def total_cost
    raw_animal_price + fixed_price + butcher_final_price
  end

  def expected_margins 
    margins = revenue_possible - total_cost
  end

  def check_for_sold
    if unsold == 0
      close_animal
    end
  end

  def close_animal
    self.toggle!(:open)
    UserMailer.animal_close(self).deliver if host.user.email.!include?("@meatup.in")
    User.admins.each do |u|
      unless u.email.include?("@meatup.in")
        UserMailer.animal_overview(self).deliver
      end
    end
    UserMailer.butcher_specs(self).deliver unless butcher.user.email.include?("@meatup.in")
  end

  # Returns a list of packages, one per cut, ordered by savings, sold-out at bottom
  def make_list
    shortened = shorten(self) # Turns all packages into a one-per list
    on_sale = remove_sold_out(shortened, self) # Removes sold_out items from list
    by_savings = arrange_packages(on_sale) # A one-per, savings-organized list
    sold_bottom = to_bottom(shortened, by_savings, self) 
    sold_bottom
  end

######################################
### VERY INEFFICIENT METHODS BELOW ###
######################################

  # A compact list of the unique "lines" sold
  def make_sold_list
    list = []
    lines.each do |line_item|
      if list.empty? || !list.any?{ |item| item.has_same_cut_and_notes_as(line_item) }
        list << line_item
      end
    end
    list.sort_by{:cut_id}
  end

  # Creates an array of hashes, organized by cut_name/notes (Boneless Ribeye is its own "bundle")
  def sold_bundles 
    master = []
    self.packages.sold.each do |p|

      bundle_name = "#{p.cut} - #{p.notes}"
      if !master.any?{ |bundle| bundle[:name] == bundle_name}
        master << { name: bundle_name, packages: [p] }
      else
        bundle = master.select{ |bundle| bundle[:name] == bundle_name }.first
        bundle[:packages] << p
      end

    end
    master.sort
  end

  # Returns a shortened list of cuts with NOTES included in ordering
  def butcher_sort(list, animal)
    array = []
    list.each do |p|
      package_list = animal.sold(p.cut)
      package_list.each do |noted_cut|
        if array.any?
          counter = 0
          array.each do |element|
            if noted_cut.cut == element.cut
              if noted_cut.line.notes == element.line.notes
                counter += 1
              end
            end
          end
          if counter == 0
            array << noted_cut
          end
        else 
          array << noted_cut
        end 
      end
    end
    array
  end


  # Creates a complete list of packages -- one per cut (sold-out included)
  def shorten(animal)
    package_array = []
    animal.packages.each do |p|
      if package_array.any?
        counter = 0
        package_array.each do |element|
          if p.cut == element.cut
            counter += 1
          end
        end
        if counter == 0
          package_array << p
        end
      else 
        package_array << p
      end 
    end
    package_array
  end

  def remove_sold_out(shortened, animal)
    cleaned_up = []
    shortened.each do |p|
      animal_list = Package.where(:animal_id => animal.id)
      full_list = animal_list.where(:cut_id => p.cut.id)
      counter = 0

      full_list.each do |package|
        unless package.sold
          # Counter > 1 means there are unsold packages
          counter += 1
        end
      end

      # A single unsold package means it's not sold out
      if counter > 0
        cleaned_up << p
      end 
    end
    cleaned_up
  end

  def arrange_packages(shortened)
    shortened.each do |p|
      savings = (100 * (p.cut.comp - p.price) / p.cut.comp)
      p.update_attribute(:savings, savings)
    end
    savings_list = shortened.sort_by{ |p| -p[:savings] }
    savings_list
  end

  def to_bottom(shortened, by_savings, animal)

    # Create a bottom layer of sold out packages
    bottom = []

    shortened.each do |p|
      animal_list = Package.where(:animal_id => animal.id)
      full_list = animal_list.where(:cut_id => p.cut.id)
      counter = 0

      full_list.each do |package|
          counter += 1 unless package.sold 
      end

      # A single unsold package means it's not sold out
      if counter == 0
        p.update_attribute(:savings, -1)
        bottom << p
      end 
    end

    # Combine, with sold-out at bottom 
    complete = []
      by_savings.each do |t|
        complete << t
      end
      bottom.each do |b|
        complete << b
      end

    complete

  end

  def sold_out(cut, animal)
    all_packages = Package.where(:animal_id => animal.id)
    cut_packages = all_packages.where(:cut_id => cut.id)
    counter = 0
    cut_packages.each do |p|
      counter += 1 unless p.sold
    end
    if counter == 0
      true
    else
      false
    end
  end

  # Returns list of packages a user placed on the animal. Separate orders ignored.
  def user_order_list
    master = []
    self.users.each do |u|
      list = []
      u.orders.where(:animal_id => self.id).each do |o|
        o.packages.each do |p|
          list << p
        end 
      end
      master << list
    end
    master  
  end

  def to_hanging
    self.pounds_sold * weight_ratio("hanging", "meat")
  end

  # Returns full list of the users who bought from the animal
  def users
    user_list = []
    self.orders.each do |o|
      counter = 0
      user_list.each do |u|
        if o.user == u
          counter += 1
        end
      end
      user_list << o.user if counter == 0 
    end
    user_list
  end

  def mult
    self.send("#{animal_type.downcase}_mult".to_sym)
  end

  def avg_price
    self.revenue_possible / self.pounds_total
  end

  def avg_weight
    self.pounds_total / self.packages.size
  end

  def get_open
    Animal.where(:open => true)
  end

  def meat_type
    "beef" if self.animal_type == "Cow"
    "pork" if self.animal_type == "Pig"
    "lamb" if self.animal_type == "Lamb"
    "goat" if self.animal_type == "Goat"
  end

  def harvest_date
    "TBD"
  end

  def butchery_date
    "TBD"
  end

  def pickup_date
    if self.name == "Donald Trump" 
      "January 12th"
    else
      "TBD"
    end
  end

  def downpaid_total
    packages.downpaid.map(&:expected_revenue).inject(:+)
  end

  def downpaid_pounds
    packages.downpaid.map(&:expected_weight).inject(:+)
  end

  def paid_total
    packages.paid.map(&:paid_revenue).inject(:+)
  end

  def paid_pounds
    packages.paid.map(&:fallback_weight).inject(:+)
  end

  def all_finalized
    packages.count == packages.complete.count + packages.paid.count
  end

  def finalize
    self.toggle!(:finalized) unless self.finalized
  end

end
