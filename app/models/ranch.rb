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
    :delivers_butcher, :delivers_drop, :delivers_host

  has_many :animals
  has_many :ranch_animals # Animal types that the ranch offers (and their details)
  belongs_to :user

  validates :zip, presence: true, length: {is: 5}
  validates :address, presence: true
  validates :state, presence: true
  validates :city, presence: true

  def self.copy_data_to_ranch_animals
    find_each do |ranch|
      Animal.types.each do |animal_type|
        if ranch.send(animal_type)
          ranch.copy_animal_data(animal_type)
        end
      end
    end
  end

  def copy_animal_data(animal_type)
    RanchAnimal.create(
      ranch_id:       id, 
      animal_type:    animal_type,
      meat_price:     price(animal_type, :meat),
      hanging_price:  price(animal_type, :hanging), 
      live_price:     price(animal_type, :live),
      fixed_cost:     fixed(animal_type)
    )
  end

  def has?(animal_type)
    info_for(animal_type).present?
  end

  def info_for(animal_type)
    ranch_animals.get(animal_type)
  end

  def price_for(animal_type, measurement)
    info_for(animal_type).price(measurement)
  end

  def cows
    info_for(:cow)
  end

  def pigs
    info_for(:pig)
  end

  def lambs
    info_for(:lamb)
  end

  def goats
    info_for(:goat)
  end

  def fixed(animal_type)
    send "#{animal_type}_fixed"
  end

end
