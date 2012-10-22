# == Schema Information
#
# Table name: animals
#
#  id           :integer          not null, primary key
#  animal_type  :string(255)
#  name         :string(255)
#  breed        :string(255)
#  weight       :integer
#  photo        :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  ranch_id     :integer
#  butcher_id   :integer
#  cow_mult     :decimal(, )
#  pig_mult     :decimal(, )
#  lamb_mult    :decimal(, )
#  goat_mult    :decimal(, )
#  host_id      :integer
#  final_sale   :boolean          default(FALSE)
#  opening_sale :boolean          default(TRUE)
#

class Animal < ActiveRecord::Base
  attr_accessible :breed, :name, :photo, :animal_type,  
                  :weight, :ranch_id, :butcher_id, :cow_mult, :pig_mult,
                  :lamb_mult, :goat_mult, :host_id, :final_sale, :opening_sale
  has_many :orders
  has_many :packages
  belongs_to :butcher
  belongs_to :ranch
  belongs_to :host
  after_create :create_packages

  validates :weight, presence: true
  validates :breed, presence: true
  validates :animal_type, presence: true
 
  def create_packages
    
    if self.butcher.vacuum_price > self.butcher.wrap_price
      @wrapping = self.butcher.vacuum_price
    else
      @wrapping = self.butcher.wrap_price
    end 

  	@cut_list = Cut.where(:animal_type => self.animal_type)
  	@cut_list.each do |c|
        if c.incentive
          # Create incentive-priced packages
          unless c.package_weight == 0
            package_number = ((self.weight * (c.percent)/100) / c.package_weight).to_i
            package_number.times do 
              Package.create!(:animal_id => self.id, :cut_id => c.id, 
                  :price => (c.price * 0.9 * multiplier(self.animal_type)), :sold => false) 
            end
          end
        else
          # Create regularly priced packages
          unless c.package_weight == 0
            package_number = ((self.weight * (c.percent)/100) / c.package_weight).to_i
            package_number.times do 
            	Package.create!(:animal_id => self.id, :cut_id => c.id, 
                  :price => (c.price * multiplier(self.animal_type)), :sold => false) 
            end
          end
        end     
    end
    self.start_opening_sale
  end

  def cut_find
	 Cut.where(:animal_type => self.animal_type)
  end

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
    total = 0
    self.packages.each do |p|
      total += p.expected_weight
    end
    total
  end

  def pounds_sold
    deposited = self.orders.where(:status => 1)
    sold = 0
    deposited.each do |o|
      o.lines.each do |l|
        l.packages.each do |p|
          sold += p.expected_weight
        end
      end
    end
    sold
  end

  def pounds_left
    total = self.pounds_total
    bought = self.pounds_sold
    left = total - bought
    left
  end 

  def percent_left
    percent = (100 * self.pounds_left) / self.pounds_total
  end  

  def start_opening_sale
    self.delay(:run_at => 120.minutes.from_now).end_opening_sale
  end

  def end_opening_sale
    if self.opening_sale
      unsold = self.packages.where(:sold => false)
      unsold.each do |p|
        if p.cut.incentive
          p.update_attribute(:price, (p.price / 0.9))
        end
      end
      self.update_attribute(:opening_sale, false)
    end
  end

  def start_final_sale
    self.end_opening_sale
    unsold = self.packages.where(:sold => false)
    unsold.each do |p|
      p.update_attribute(:price, (p.price * 0.85))
    end
    self.update_attribute(:final_sale, true)
  end  

  def unsold
    self.packages.where(:sold => false)
  end

  def sold
    self.packages.where(:sold => false)
  end

  def cut_packages(cut)
    all_packages = Package.where(:animal_id => self.id)
    all_packages.where(:cut_id => cut.id)
  end

  def sold(cut)
    self.cut_packages(cut).where(:sold => true)
  end

  def unsold(cut)
    self.cut_packages(cut).where(:sold => false)
  end
end
