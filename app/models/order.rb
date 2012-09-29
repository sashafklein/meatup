# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  status     :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  animal_id  :integer
#

class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :animal
  attr_accessible :status, :lines_attributes, :animal_id, :user_id

  has_many :lines
  has_many :cuts

  accepts_nested_attributes_for :lines
  accepts_nested_attributes_for :cuts

  def animalfind
  	Animal.find(self.animal_id)
  end

end
