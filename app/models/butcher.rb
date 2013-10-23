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
  attr_accessible :address, :city, :state, :zip, :boneless, :final_price, :ground, :hanging_price, :name, :phone, :stew, :user_id, :vacuum_price, :wrap_price  
  has_many :animals

  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :phone, presence: true
  validates :name, presence: true
  validates :zip, presence: true, length: { is: 5 }

  def wrapping_price
    vacuum_price > wrap_price ? vaccuum_price : wrap_price
  end

  def real_final_price
    final_price ? final_price : 0
  end
end
