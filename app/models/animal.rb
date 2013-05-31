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
  belongs_to :butcher
  belongs_to :ranch
  belongs_to :host
  after_create :create_packages

  accepts_nested_attributes_for :packages

  validates :weight, presence: true
  validates :breed, presence: true
  validates :animal_type, presence: true

  scope :sold, packages.where(:sold => true)
  scope :unsold, packages.where(:sold => false)
 
  def create_packages

    v = self.butcher.vacuum_price
    b = self.butcher.wrap_price
    v > b ? @wrapping = v : @wrapping = b

  	@cut_list = Cut.where(:animal_type => animal_type)
  	@cut_list.each do |c|
      if c.package_weight != 0 
        if c.incentive
        # Create incentive package pricing
          p_price = c.price * 0.9 #* multiplier(self.animal_type)
          package_number = ((weight * (c.percent)/100) / c.package_weight).to_i
        else
        # Create regular package pricing
          p_price = c.price #* multiplier(self.animal_type)
          package_number = ((weight * (c.percent)/100) / c.package_weight).to_i
        end 

        package_number.times do 
          Package.create!(:animal_id => id, :cut_id => c.id, 
              :price => p_price, :sold => false, :savings => c.savings)
        end
      end
    end
    start_opening_sale
  end

  def cut_find
	 Cut.where(:animal_type => animal_type)
  end

  # WHAT DOES THIS DO??? I THINK IT DOESN'T DO IT
  def multiplier(string)

    @r = self.ranch
    @b = self.butcher

    if @b.vacuum_price > @b.wrap_price
      @wrapping = @b.vacuum_price
    else
      @wrapping = @b.wrap_price
    end 

    # Mult is the total per pound meat price including butchery fees
    self.cow_mult = (@r.cow_meat + (@b.hanging_price + @wrapping) / CMOH) / 4.401
    self.pig_mult = 1
    self.lamb_mult = 1
    self.goat_mult = 1

    if string == "Cow"
      self.cow_mult
    elsif string == "Pig"
      self.pig_mult
    elsif string == "Lamb"
      self.lamb_mult
    elsif string == "Goat"
      self.goat_mult
    end
  end

  def pounds_total
    packages.inject{ |sum, n| sum + p.expected_weight }
  end

  def pounds_sold
    sold_weight = 0
    orders.each do |o|
      o.packages.each do |p|
        sold_weight += p.expected_weight if p.sold
      end
    end
    sold_weight
  end

  def pounds_left
    pounds_total - pounds_sold
  end 

  def percent_left
    (100 * pounds_left) / pounds_total
  end  

  def start_opening_sale
    unless no_sales
      if opening_sale
        delay(:run_at => 120.minutes.from_now).end_opening_sale
      end
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
    sold.inject{ |sum, p| sum + (p.price * p.cut.package_weight) }
  end

  def revenue_possible
    packages.inject{ |sum, p| sum + (p.expected_weight * p.price) }
  end

  def left_to_make
    revenue_possible - revenue_made
  end

  # Returns total cost (for meat, butchery, and fixed, for the given animal)
  def total_cost

    # Determining variables on the basis of animal_type
    cost = 0
    case animal_type 
    when "Cow"
      a_meat = ranch.cow_meat
      a_hanging = ranch.cow_hanging
      a_live = ranch.cow_live
      amol = CMOL
      ahol = CHOL
      fixed = ranch.cow_fixed if fixed
    when "Pig"
      a_meat = ranch.pig_meat
      a_hanging = ranch.pig_hanging
      a_live = ranch.pig_live
      amol = PMOL
      ahol = PHOL
      fixed = ranch.pig_fixed if fixed
    when "Lamb"
      a_meat = ranch.lamb_meat
      a_hanging = ranch.lamb_hanging
      a_live = ranch.lamb_live
      amol = LMOL
      ahol = LHOL      
      fixed = ranch.lamb_fixed if fixed
    when "Goat"
      a_meat = ranch.goat_meat
      a_hanging = ranch.goat_hanging
      a_live = ranch.goat_live
      amol = GMOL
      ahol = GHOL
      fixed = ranch.goat_fixed if fixed
    end
    

    if a_meat > 0
      cost = a_meat * amol * weight
    elsif a_hanging > 0
      cost = a_hanging * ahol * weight
    else
      cost = a_live * weight
    end

    if fixed != 0 && fixed != nil
      cost += fixed
    end

    if butcher.final_price
      cost += butcher.final_price
    end

    cost
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

  # Similar to the above, but with no sold-out ordering, as everything is sold out.
  # Also, elements of the list are differentiated by line notes.

  def make_sold_list
    list = []
    self.orders.each do |o|
      o.lines.each do |l|
        if list.any?
          counter = 0
          list.each do |element|
            if l.cut == element.cut && l.notes == element.notes
              counter += 1
            end
          end
          list << l if counter == 0
        else
          list << l
        end
      end
    end
    list.sort_by{:cut_id}
  end

  # Creates an array of arrays by notes/cut (Boneless Ribeye is its own array)
  def sold_bundles 
    master = []
    self.packages.each do |p|
      if p.sold

        # The master has sublists
        if master.any?
          counter = 0

          # Check for matching list. Add if found.
          master.each do |list|
            if p.notes == list.first.notes && p.cut == list.first.cut
              list << p
              counter += 1 # Don't create list is appropriate one found.
            end
          end
          if counter == 0
            master << [p] if counter == 0 # Add as new list if list doesn't yet exist.
          end
        else # If master is empty, add the package to a new sub-list.
            master << [p]
        end

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
    return self.pounds_sold * CHOM if self.animal_type == "Cow"
    return self.pounds_sold * PHOM if self.animal_type == "Pig"
    return self.pounds_sold * LHOM if self.animal_type == "Lamb"
    return self.pounds_sold * GHOM if self.animal_type == "Goat"
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
    cow_mult if self.animal_type == "Cow"
    pig_mult if self.animal_type == "Pig"
    lamb_mult if self.animal_type == "Lamb"
    goat_mult if self.animal_type == "Goat"
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

  def incomplete_orders
    self.orders.where(:status => 0)
  end

  def downpaid_orders
    self.orders.where(:status => 1)
  end

  def paid_orders
    self.orders.where(:status => 2)
  end

  def complete_orders
    self.orders.where(:status => 3)
  end

  def downpaid_total
    total = 0
    self.downpaid_orders.each do |o|
      o.packages.each do |p|
        total += p.price * p.expected_weight
      end
    end
    total
  end

  def downpaid_pounds
    total = 0
    self.downpaid_orders.each do |o|
      o.packages.each do |p|
        total += p.expected_weight
      end
    end
    total
  end


  def paid_total
    total = 0
    self.paid_orders.each do |o|
      o.packages.each do |p|
        if p.true_weight
          total += p.true_weight * p.price
        else 
          total += p.expected_weight * p.price
        end
      end
    end
    total
  end

  def paid_pounds
    total = 0
    self.paid_orders.each do |o|
      o.packages.each do |p|
        if p.true_weight
          total += p.true_weight
        else 
          total += p.expected_weight
        end
      end
    end
    total
  end

  def all_finalized
    return false if self.orders.select{ |o| o.status < 2 }.length > 0 
    return true
  end

  def finalize
    self.toggle!(:finalized) unless self.finalized
  end

end
