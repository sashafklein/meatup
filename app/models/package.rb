# == Schema Information
#
# Table name: packages
#
#  id         :integer          not null, primary key
#  cut_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  animal_id  :integer
#  price      :decimal(, )
#  line_id    :integer
#  sold       :boolean
#

class Package < ActiveRecord::Base
  attr_accessible :animal_id, :cut_id, :price, :line_id, :sold

  belongs_to :animal
  belongs_to :cut
  belongs_to :line

end
