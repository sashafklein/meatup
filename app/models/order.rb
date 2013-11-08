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

  include StatusMethods

  class OrderError < StandardError; end

  def save_with_lines(new_lines)
    if save!
      cleaned_new_lines = new_lines.map(&:last).reject{ |l| l[:units].to_i == 0 }
      Line.create_lines_and_decrement_packages(cleaned_new_lines, self)
    else
      raise OrderError.new "Order failed to save! Order: #{self.inspect}"
    end
    update_attribute(:total, make_total)
  end

  def rollback!
    unless packages.update_all(sold: false, line_id: nil, price: nil, savings: nil) 
      raise OrderError.new("The packages were not successfully updated! Order: #{inspect}")
    end

    unless self.destroy
      raise OrderError.new("The order was not destroyed! Order: #{id}")
    end
  end

  def poundage
    lines.map(&:poundage).sum
  end

  # Returns the total cost of a given order
  def total_calc
    packages.map(&:expected_revenue).sum
  end

  def apply_apology_discount!
    packages.update_all(price: price * 0.9)
  end

  def discounted
    packages.map{ |p| p.expected_revenue / 10}.sum
  end

  def get_difference
    packages.map(&:revenue_diff).sum
  end  

  def true_weight
    packages.weighed.map(&:true_weight).sum
  end

  def real
    packages.first.true_weight.present?
  end

  def to_total
    total ? total : lines.map(&:revenue).sum
  end
  
  def make_total
    packages.map(&:fallback_revenue).sum
  end

end
