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

  after_create :schedule_check_payment

  accepts_nested_attributes_for :lines
  accepts_nested_attributes_for :cuts

  def schedule_check_payment
    self.delay(:run_at => 5.minutes.from_now).check_payment
  end

  def check_payment
    rollback if status == 0
  end

  def rollback
    packages.update_all!(sold: false, line_id: nil) 
    self.destroy
  end

  def poundage
    lines.map(&:poundage).inject(:+)
  end

  # Returns the total cost of a given order
  def total_calc
    packages.map(&:expected_revenue).inject(:+)
  end

  def apology_discount
    packages.update_all(price: (p.price * 0.9))
  end

  def discounted
    packages.map{ |p| p.expected_revenue / 10).inject(:+)
  end

  def get_difference
    packages.map(&:revenue_difference_from_expectations).inject(:+)
  end  

  def true_weight
    packages.map(&:true_weight).inject(:+)
  end

  def real
    packages.first.true_weight.present?
  end

  def to_total
    total ? total : packages.map(&:expected_revenue).inject(:+)
  end
  
  def make_total
    packages.map(&:expected_revenue).inject(:+)
  end

end
