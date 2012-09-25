class Animal < ActiveRecord::Base
  attr_accessible :breed, :farm, :host, :name, :photo, :animal_type, :weight
  has_many :orders
  has_many :packages
  after_create :create_packages

 public
 
  def create_packages
  	@cut_list = Cut.where(:animal_type => self.animal_type)
  	@cut_list.each do |c|
		Package.create!(:animal_id => self.id, :cut_id => c.id, 
			:original => (self.weight * (c.percent)/100) / c.package_weight, 
			:left => (self.weight * (c.percent)/100) / c.package_weight)
	  end
  end

  def cut_find
	Cut.where(:animal_type => self.animal_type)
  end

	

	
end
