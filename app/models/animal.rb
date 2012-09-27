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
#

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
