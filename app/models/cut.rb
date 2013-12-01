# == Schema Information
#
# Table name: cuts
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  price          :float
#  percent        :float
#  package_weight :float
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  animal_type    :string(255)
#  comp           :float
#  savings        :integer
#  incentive      :boolean          default(FALSE)
#  description    :text
#  prep_options   :string(255)
#

class Cut < ActiveRecord::Base
  attr_accessible :name, :package_weight, :percent, 
                  :price, :animal_type, :comp, :savings, 
                  :incentive, :description, :prep_options

  scope :cow, where(:animal_type == "Cow")
  scope :pig, where(:animal_type == "Pig")
  scope :goat, where(:animal_type == "Goat")
  scope :lamb, where(:animal_type == "Lamb")
  scope :weighted, -> { where('package_weight > ?', 0) }
  scope :incentive_price, -> { where(incentive: true) }

  validates :price, :percent, :package_weight, 
            :name, :description, :animal_type,
            presence: true

  def retail_price_benchmark
    comp
  end

end
