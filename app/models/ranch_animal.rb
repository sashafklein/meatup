class RanchAnimal < ActiveRecord::Base
  attr_accessible :animal_type, :fixed_cost, :hanging_price, :live_price, :meat_price, :ranch_id
end
