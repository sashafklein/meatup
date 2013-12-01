# == Schema Information
#
# Table name: ranches
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  address           :string(255)
#  phone             :string(255)
#  user_id           :integer
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
#  description       :string(255)
#

class Ranch < ActiveRecord::Base
  attr_accessible :address, :city, :state, :zip, 
    :name, :phone, :user_id, :preferred_butcher, :has_csa, 
    :delivers_butcher, :delivers_drop, :delivers_host, :location_id

  has_many :animals
  has_many :ranch_animals
  belongs_to :user

  include Locatable

  validate :location_sufficient

  def has?(animal_type)
    info_for(animal_type).present?
  end

  def price_for(animal_type, measurement)
    info_for(animal_type).price(measurement)
  end

  private

  def info_for(animal_type)
    ranch_animals.get(animal_type)
  end
end
