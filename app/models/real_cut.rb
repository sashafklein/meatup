class RealCut < ActiveRecord::Base
  attr_accessible :animal_id, :cut_id, :flat_price, :weight, :expected_units, :sold_units
end