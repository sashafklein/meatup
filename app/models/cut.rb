class Cut < ActiveRecord::Base
  attr_accessible :name, :package_weight, :percent, :price, :animal_type
  belongs_to :line
end
