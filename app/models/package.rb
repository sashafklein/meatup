# == Schema Information
#
# Table name: packages
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  price       :float
#  line_id     :integer
#  savings     :integer
#  true_weight :float
#  sold        :boolean          default(FALSE)
#  animal_id   :integer
#  cut_id      :integer
#  real_cut_id :integer
#

class Package < ActiveRecord::Base

  include PackageStatusMethods
  include WeightAndPriceMethods

  attr_accessible :real_cut_id, :price, :line_id, :sold, :savings, :actual_lbs, :actual_oz, :true_weight
  attr_reader :actual_lbs, :actual_oz

  belongs_to :real_cut
  belongs_to :line

  delegate   :order, :notes, to: :line
  delegate   :animal, :cut, to: :real_cut
  delegate   :user, to: :order

  before_update :to_true

  scope :sold, -> { where(:sold => true) }
  scope :unsold, -> { where(:sold => false) }
  scope :weighed, -> { where('true_weight IS DISTINCT FROM NULL') }
  scope :unweighed, -> { where(true_weight: nil) }

  validates :real_cut_id, presence: :true

  def cut_siblings
    real_cut.packages
  end

  def expected_weight
    real_cut.weight
  end

  private

  def to_true
    if ready_to_weigh && new_weight_present?
      true_weight =  actual_lbs + actual_oz
    end
  end

  def actual_lbs=(val)
    @actual_lbs = val.to_f
  end

  def actual_oz=(val)
    @actual_oz = val.to_f
  end

  def new_weight_present?
    actual_lbs && actual_oz && actual_lbs + actual_oz > 0
  end
end
