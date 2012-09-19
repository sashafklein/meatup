class Cut < ActiveRecord::Base
  belongs_to :line
  attr_accessible :name, :package, :percent, :price
end
