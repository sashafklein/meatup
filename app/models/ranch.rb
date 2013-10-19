# == Schema Information
#
# Table name: ranches
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  address           :string(255)
#  phone             :string(255)
#  user_id           :integer
#  cow               :boolean          default(FALSE)
#  pig               :boolean          default(FALSE)
#  lamb              :boolean          default(FALSE)
#  goat              :boolean          default(FALSE)
#  cow_live          :float
#  pig_live          :float
#  goat_live         :float
#  lamb_live         :float
#  cow_meat          :float
#  pig_meat          :float
#  lamb_meat         :float
#  goat_meat         :float
#  cow_hanging       :float
#  pig_hanging       :float
#  lamb_hanging      :float
#  goat_hanging      :float
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  state             :string(255)
#  zip               :string(255)
#  city              :string(255)
#  preferred_butcher :integer
#  has_csa           :boolean          default(FALSE)
#  delivers_butcher  :boolean          default(FALSE)
#  delivers_drop     :boolean          default(FALSE)
#  delivers_host     :boolean          default(FALSE)
#  cow_fixed         :integer          default(0)
#  pig_fixed         :integer          default(0)
#  lamb_fixed        :integer          default(0)
#  goat_fixed        :integer          default(0)
#  description       :string(255)
#

class Ranch < ActiveRecord::Base
  attr_accessible :address, :city, :state, :zip, 
    :name, :phone, :user_id, :preferred_butcher, :has_csa, 
    :delivers_butcher, :delivers_drop, :delivers_host,
    :cow, :cow_meat, :cow_hanging, :cow_live, 
    :goat, :goat_meat, :goat_hanging, :goat_live, 
    :lamb, :lamb_meat, :lamb_hanging, :lamb_live, 
    :pig, :pig_meat, :pig_hanging, :pig_live, 
    :cow_fixed, :pig_fixed, 
    :lamb_fixed, :goat_fixed

  has_many :animals
  belongs_to :user
  after_create :to_meat
  after_update :to_meat

  validates :zip, presence: true, length: {is: 5}
  validates :address, presence: true
  validates :state, presence: true
  validates :city, presence: true

  def to_meat 
    animal_types = %w( cow pig lamb goat )

    animal_types.each do |animal_type|
      replace_meat_price_with_hanging_or_live(animal_type) if !has_price_for?(animal_type, :meat)
    end
  end

  def replace_meat_price_with_hanging_or_live(animal_type)
    [:hanging, :live].select{ |meas| has_price_for?(meas) }.each do |measurement| 
      return convert_from_measurement(measurement, animal_type) # first to have price returns
    end
  end 

  def convert_from_measurement(measurement, animal_type)
    update_attribute "#{animal_type}_meat", meat_from_measurement(measurement, animal_type)
  end

  def has_price_for?(animal_type, measurement)
    specific_price = price(animal_type, measurement)
    specific_price.present? && !specific_price.zero?
  end


  def meat_from_measurement(measurement, animal_type)
    price(animal_type, measurement) / WeightRatio.new(animal_type).ratio(:meat, measurement)
  end

  def price(animal_type, measurement)
    send "#{animal_type}_#{measurement}"
  rescue
    nil
  end

  def prices_for_animal(animal_type)
    {
      meat: price( :meat, animal_type ),
      hanging: price( :hanging, animal_type ),
      live: price( :live, animal_type )
    }
  end

end
