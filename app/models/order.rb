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
#  total      :float
#  difference :float
#

class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :animal
  attr_accessible :status, :lines_attributes, :animal_id, :user_id, :total

  has_many :cuts
  has_many :lines, :dependent => :destroy
  has_many :packages, through: :lines

  accepts_nested_attributes_for :lines
  accepts_nested_attributes_for :cuts

  scope :incomplete,  -> { where(status: 0) }
  scope :downpaid,    -> { where(status: 1) }
  scope :paid,        -> { where(status: 2) }
  scope :complete,    -> { where(status: 3) }
  scope :finalized,   -> { where(status: 4) }

  delegate :ranch, to: :animal

  include StatusMethods

  class OrderError < StandardError; end

  def save_with_lines!(new_lines)
    if save!
      cleaned_new_lines = new_lines.reject{ |l| l.units == 0 }
      Line.create_from_cleaned!(cleaned_new_lines, self)
    else
      raise OrderError.new "Order failed to save! Order: #{self.inspect}"
    end
  end

  def self.create_from_lines!(user_id, animal_id, lines)
    order = Order.new(user_id: user_id, animal_id: animal_id)
    order.save_with_lines!(lines)
  end

  def rollback!

    lines.each{ |line| line.rollback! }

    unless self.destroy
      raise OrderError.new("The order was not destroyed! Order: #{id}")
    end
  end

  def poundage
    lines.sum(&:pounds)
  end

  # Returns the total cost of a given order
  def total_calc
    packages.sum(&:expected_revenue)
  end

  def get_difference
    packages.sum(&:revenue_diff)
  end  

  def fallback_weight
    real ? true_weight : poundage
  end

  def true_weight
    packages.weighed.sum(&:true_weight)
  end

  def real
    packages.first.true_weight.present?
  end

  def total
    lines.sum(&:revenue)
  end

  def downpay_total
    lines.sum(&:revenue) * 0.8
  end

  def to_total
    total ? total : lines.sum(&:revenue)
  end

  def increment_status!
    update_attribute(:status, status + 1)
  end

  def update_total!
    update_attribute(:total, make_total)
  end

  private

  def make_total
    packages.sum(&:fallback_revenue)
  end
end
