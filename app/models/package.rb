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
  attr_reader :actual_lbs, :actual_oz

  belongs_to :animal
  belongs_to :cut
  belongs_to :line

  delegate   :order, to: :line, :allow_nil => true
  before_update :to_true

  scope :sold, -> { where(:sold => true) }
  scope :unsold, -> { where(:sold => false) }

  # Array of Open Structs grouping packages by :sold, :savings, and cut name;
  # Sold Out at bottom, then ordered with savings at top.
  def self.by_cut_sale_and_savings
    unsold.in_savings_bundles + sold.in_savings_bundles
  end

  def self.in_savings_bundles
    bundles = group_by{ |p| [p.savings, p.cut.name] }.sort
    bundles.map do |bundle|
      OpenStruct.new(
        cut_name: bundle[0][1],
        savings: bundle[0][0],
        packages: bundle[1]
      )
    end
  end

  def self.sold_in_line_note_bundles
    bundles = sold.group_by{ |p| [p.cut.name, p.line.notes] }.sort
    bundles.map do |bundle|
      OpenStruct.new(
        cut_name: bundle[0][0],
        notes: bundle[0][1],
        packages: bundle[1]
      )
    end
  end

  def incentivized
    cut_ids = animal.cutlist.incentive_priced.pluck(:id)
    where(cut_id: cut_ids)
  end

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
      true_weight =  actual_lbs + actual_oz
    end
  end

  def new_weight_present?
    actual_lbs && actual_oz && actual_lbs + actual_oz > 0
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
    @actual_lbs = val.to_f
  end

  def actual_oz=(val)
    @actual_oz = val.to_f
  end

  def incentive_priced?
    cut.incentive
  end

  def get_savings_from_benchmark(new_price = nil)
    new_price ||= price
    1 - (new_price / cut.retail_price_benchmark)
  end

  def remove_from_opening_sale
    update_attributes!(
      price: price / 0.9,
      savings: get_savings_from_benchmark(price / 0.9)
    )
  end

  def start_final_sale
    update_attributes!(
      price: price * 0.85,
      savings: get_savings_from_benchmark(price * 0.85)
    )
  end
end
