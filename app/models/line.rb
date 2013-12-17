# == Schema Information
#
# Table name: lines
#
#  id          :integer          not null, primary key
#  units       :integer
#  notes       :string(255)      default("")
#  order_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  real_cut_id :integer
#  sale_price  :integer
#

class Line < ActiveRecord::Base

  attr_accessible :notes, :units, :order_id, :real_cut_id, :sale_price, :dependent => :destroy
  
  belongs_to :order
  belongs_to :real_cut
  has_many   :packages
  delegate   :animal, to: :order, :allow_nil => true
  delegate   :cut_id, :cut, to: :real_cut

  before_save  :ensure_sale_price!
  after_create :create_packages!
  after_create :update_order_total!

  scope :weighed, -> { joins(:packages).merge(Package.weighed) }
  scope :unweighed, -> { joins(:packages).merge(Package.unweighed) }

  validate :real_cut_id, :sale_price, presence: true

  class LineError < StandardError; end

  def self.create_from_cleaned!(new_lines, order)
    new_lines.each do |l| 
      l.order_id = order.id
      l.save!
    end
  end

  def self.from_attrs(line_attrs)
    line_attrs.map{ |l| Line.new(l.last) }.reject(&:without_units)
  end

  def rollback!
    unless real_cut.update_attributes!(sold_units: real_cut.sold_units - units)
      raise LineError.new("The real cut failed to update sold units! RealCut: #{real_cut.inspect}")
    end

    unless packages.destroy_all
      raise LineError.new("The packages were not successfully destroyed! Line: #{inspect}")
    end
  end

  def create_packages!
    units.times do
      self.packages.create!(real_cut_id: real_cut_id)
    end
    real_cut.update_attributes!(sold_units: real_cut.sold_units + units)
  end

  def expected_weight
    cut.package_weight
  end

  def weight_diff
    return nil unless real_weight
    expected_weight - real_weight
  end

  def revenue
    weighed? ? weighed_revenue : unweighed_revenue
  end

  def pounds
    weighed? ? weighed_pounds : unweighed_pounds
  end

  def weighed_pounds
    packages.sum(:true_weight)
  end

  def unweighed_pounds
    units * real_cut.weight
  end

  def unweighed_revenue
    sale_price * unweighed_pounds
  end

  def weighed_revenue
    sale_price * weighed_pounds
  end

  def processed_notes
    notes.blank? ? "None" : notes
  end

  def weighed?
    packages.pluck(:true_weight).all?
  end

  def price
    real_cut.list_price
  end

  private

  def ensure_sale_price!
    self.sale_price ||= real_cut.list_price
  end

  def update_order_total!
    order.update_total!
  end

  def real_weight
    return nil if packages.pluck(:true_weight).include?(nil)
    packages.pluck(:true_weight).sum
  end
end
