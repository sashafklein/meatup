# == Schema Information
#
# Table name: packages
#
#  id          :integer          not null, primary key
#  cut_id      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  animal_id   :integer
#  price       :float
#  line_id     :integer
#  sold        :boolean
#  savings     :integer
#  true_weight :float
#

class Package < ActiveRecord::Base

  include PackageStatusMethods
  include WeightAndPriceMethods

  attr_accessible :animal_id, :cut_id, :price, :line_id, :sold, :savings, :actual_lbs, :actual_oz, :true_weight

  belongs_to :animal, :cut, :line
  delegate   :order, to: :line, :allow_nil => true
  before_update :to_true

  scope :sold, where(:sold => true)
  scope :unsold, where(:sold => false)

  def cut_siblings
    animal.packages.where(:cut_id => cut.id)
  end

  def line_siblings
    line.packages
  end

  def label_list
  	line_siblings.to_a
  end

  def user
    order.user
  end

  def identical_sold
    line_item_ids = animal.lines.where(notes: p.notes).pluck(:id)
    animal.packages.sold.where(line_id: line_item_ids)
  end

  def to_true
    if ready_to_weigh && new_weight_present?
      update_attribute(:true_weight, actual_lbs + actual_oz)
    end
  end

  def new_weight_present?
    actual_lbs + actual_oz <= 0
  end

  def ready_to_weigh
    sold && downpaid && true_weight.blank?
  end

  def notes
    line.notes if sold
  end

  def finalized
    order.status > 2
  end

  def actual_lbs=(val)
    true_weight_will_change!
    @actual_lbs=val
  end

  def actual_lbs
    actual_lbs.to_f
  end

  def actual_oz
    actual_oz.to_f
  end
end
