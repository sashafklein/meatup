# == Schema Information
#
# Table name: packages
#
#  id         :integer          not null, primary key
#  cut_id     :integer
#  original   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  animal_id  :integer
#  left       :integer
#  price      :decimal(, )
#

class Package < ActiveRecord::Base
  attr_accessible :animal_id, :cut_id, :original, :left, :price, :line_id

  belongs_to :animal
  belongs_to :cut

end
