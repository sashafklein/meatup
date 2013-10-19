# == Schema Information
#
# Table name: cuts
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  price          :float
#  percent        :float
#  package_weight :float
#  line_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  animal_type    :string(255)
#  comp           :float
#  savings        :integer
#  incentive      :boolean          default(FALSE)
#  description    :text
#

class Cut < ActiveRecord::Base
  attr_accessible :name, :package_weight, :percent, 
                  :price, :animal_type, :comp, :savings, 
                  :incentive, :description

  scope :cow, where(:animal_type == "Cow")
  scope :pig, where(:animal_type == "Pig")
  scope :goat, where(:animal_type == "Goat")
  scope :lamb, where(:animal_type == "Lamb")
  scope :weighted, -> { where('package_weight > ?', 0) }

  validates :price, :percent, :package_weight, 
            :name, :description, :animal_type,
            presence: true

  def number_of_packages_for_animal(weight)
    (weight * (percent / 100) / package_weight).to_i
  end

  def package_price
    incentive ? price * 0.9 : price
  end
end
