class RanchAnimal < ActiveRecord::Base
  attr_accessible :animal_type, :fixed_cost, :hanging_price, :live_price, :meat_price, :ranch_id

  validates :animal_type, :ranch_id, presence: true

  belongs_to :ranch

  after_create :to_meat

  def self.get(type)
    find_by_animal_type(type)
  rescue
    nil
  end

  def to_meat 
    replace_meat_price_with_hanging_or_live if !has_price_for?(:meat)
  end

  def replace_meat_price_with_hanging_or_live
    [:hanging, :live].select{ |meas| has_price_for?(meas) }.each do |measurement| 
      return convert_from_measurement(measurement) # first to have price returns
    end
  end 

  def convert_from_measurement(measurement)
    update_attribute :meat_price, meat_from_measurement(measurement)
  end

  def meat_from_measurement(measurement)
    price(measurement) / WeightRatio.new(animal_type).ratio(:meat, measurement)
  end

  def price(measurement)
    send "#{measurement}_price"
  rescue
    nil
  end

  def fixed_price
    fixed_cost
  end

  def has_price_for?(measurement)
    price(measurement).present?
  end

  def price_list
    {
      meat: meat_price,
      hanging: hanging_price,
      live: live_price,
      fixed: fixed_price
    }
  end
end
