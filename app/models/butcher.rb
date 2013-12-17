# == Schema Information
#
# Table name: butchers
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  address       :string(255)
#  hanging_price :decimal(, )
#  final_price   :decimal(, )
#  vacuum_price  :decimal(, )
#  wrap_price    :decimal(, )
#  phone         :string(255)
#  user_id       :integer
#  ground        :boolean
#  stew          :boolean
#  boneless      :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  state         :string(255)
#  zip           :string(255)
#  city          :string(255)
#

class Butcher < ActiveRecord::Base
  attr_accessible :address, :city, :state, :zip, :boneless, :final_price, :ground, :hanging_price, :name, :phone, :stew, :user_id, :vacuum_price, :wrap_price, :location_id  
  has_many :animals
  belongs_to :location

  include Locatable
  
  validates :name, presence: true
  after_create :location_sufficient

  def create!(opts={})
    binding.pry
  end

  def wrapping_price
    vacuum_price > wrap_price ? vaccuum_price : wrap_price
  end

  def real_final_price
    final_price ? final_price : 0
  end
end
