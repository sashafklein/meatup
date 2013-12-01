# == Schema Information
#
# Table name: hosts
#
#  id         :integer          not null, primary key
#  address    :string(255)
#  city       :string(255)
#  state      :string(255)
#  phone      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  zip        :string(255)
#  user_id    :integer
#

class Host < ActiveRecord::Base
  attr_accessible :address, :city, :phone, :state, :zip, :user_id, :location_id
  belongs_to :user
  has_many :animals

  include Locatable

  validate :location_complete
  
  def name
  	user.name
  end
end
