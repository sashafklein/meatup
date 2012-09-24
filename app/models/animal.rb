class Animal < ActiveRecord::Base
  attr_accessible :breed, :farm, :host, :name, :photo, :animal_type, :weight
  has_many :orders
  has_many :packages

	def cutfind
		Cut.where(:animal_type => self.animal_type)
	end

	def packagefind
		Package.where(:animal_id => self.id)
	end
end
