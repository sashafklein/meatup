class Animal < ActiveRecord::Base
  attr_accessible :breed, :farm, :host, :name, :photo, :animal_type, :weight
  has_many :orders

	def cutfind
		Cut.where(:animal_type => self.animal_type)
	end
end
