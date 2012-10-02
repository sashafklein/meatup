# == Schema Information
#
# Table name: animals
#
#  id          :integer          not null, primary key
#  animal_type :string(255)
#  name        :string(255)
#  breed       :string(255)
#  weight      :integer
#  farm        :string(255)
#  host        :string(255)
#  photo       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  ranch_id    :integer
#  butcher_id  :integer
#

class Animal < ActiveRecord::Base
  attr_accessible :breed, :farm, :host, :name, :photo, :animal_type,  
                  :weight, :ranch_id, :butcher_id, :cow_mult, :pig_mult,
                  :lamb_mult, :goat_mult
  has_many :orders
  has_many :packages
  belongs_to :butcher
  belongs_to :ranch
  after_create :create_packages
  before_save :defaults

 public
 
  def create_packages
  	@cut_list = Cut.where(:animal_type => self.animal_type)
  	@cut_list.each do |c|
    if self.butcher.vacuum_price > self.butcher.wrap_price
      @wrapping = self.butcher.vacuum_price
    else
      @wrapping = self.butcher.wrap_price
    end 
		Package.create!(:animal_id => self.id, :cut_id => c.id, 
			:original => (self.weight * (c.percent)/100) / c.package_weight, 
			:left => (self.weight * (c.percent)/100) / c.package_weight, 
      :price => (c.price + self.butcher.final_price + @wrapping) * multiplier(self.animal_type)) 
	  end
  end

  def cut_find
	Cut.where(:animal_type => self.animal_type)
  end

  def defaults
    if self.butcher.vacuum_price > self.butcher.wrap_price
      @wrapping = self.butcher.vacuum_price
    else
      @wrapping = self.butcher.wrap_price
    end 
    # Mult is the total per pound meat price including butchery fees
    self.cow_mult = ((self.ranch.cow_meat + self.butcher.final_price + @wrapping)/ 4.31)
    self.pig_mult = 1
    self.lamb_mult = 1
    self.goat_mult = 1
  end

  def multiplier(string)
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
	
end
