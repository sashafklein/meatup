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
#

class Butcher < ActiveRecord::Base
  attr_accessible :address, :boneless, :final_price, :ground, :hanging_price, :name, :phone, :stew, :user_id, :vacuum_price, :wrap_price
  before_save :default_values

  has_many :animals

  def default_values
  	self.ground ||= false
  	self.stew ||= false
  	self.boneless ||= false
  	self.hanging_price ||= 0
  	self.final_price ||= 0
  	self.wrap_price ||= 0
  	self.vacuum_price ||= 0
  	self.phone ||= "None"
  end

end
