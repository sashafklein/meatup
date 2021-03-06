# == Schema Information
#
# Table name: ranch_animals
#
#  id            :integer          not null, primary key
#  animal_type   :string(255)
#  meat_price    :float
#  hanging_price :float
#  live_price    :float
#  fixed_cost    :float            default(0.0)
#  ranch_id      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class RanchAnimal < ActiveRecord::Base
  attr_accessible :animal_type, :fixed_cost, :hanging_price, :live_price, :meat_price, :ranch_id

  validates :animal_type, presence: true

  belongs_to :ranch

  after_create :to_meat

  def self.get(type)
    find_by_animal_type(type)
  rescue
    nil
  end

  def price(measurement)
    send "#{measurement}_price"
  rescue
    nil
  end

  private

  def convert_from_measurement(measurement)
    update_attribute :meat_price, meat_from_measurement(measurement)
  end

  def meat_from_measurement(measurement)
    price(measurement) / WeightRatio.new(animal_type).ratio(:meat, measurement)
  end

  def to_meat 
    replace_meat_price_with_hanging_or_live if !has_price_for?(:meat)
  end

  def replace_meat_price_with_hanging_or_live
    [:hanging, :live].select{ |meas| has_price_for?(meas) }.each do |measurement| 
      return convert_from_measurement(measurement) # first to have price returns
    end
  end 

  def has_price_for?(measurement)
    price(measurement).present?
  end

  def fixed_price
    fixed_cost
  end
end
