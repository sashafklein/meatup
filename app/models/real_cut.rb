class RealCut < ActiveRecord::Base
  attr_accessible :animal_id, :cut_id, :flat_price, :weight, :expected_units, :sold_units

  belongs_to :cut
  belongs_to :animal

  delegate :name, to: :cut
end