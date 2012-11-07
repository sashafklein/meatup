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

  after_create :schedule_check_payment

  accepts_nested_attributes_for :lines
  accepts_nested_attributes_for :cuts

  def schedule_check_payment
    self.delay(:run_at => 5.minutes.from_now).check_payment
  end

  def check_payment
    self.reload
    if self.status == 0
      self.lines.each do |l|
        l.packages.each do |p|
          p.update_attributes(:sold => false, :line_id => nil)
        end 
      end
      self.destroy
    end
  end

  def poundage
    pounds = 0
    lines = self.lines
    lines.each do |l|
      pounds += l.units * l.expected_weight
    end
    return pounds
  end

  # Returns the total cost of a given order
  def total_calc
    total = 0
    lines = self.lines
    lines.each do |l|
      pkgs = l.packages
      pkgs.each do |p|
        total += p.price * p.expected_weight
      end
    end
    return total
  end

  def apology_discount
    self.lines.each do |l|
      l.packages.each do |p|
        p.update_attribute(:price, (p.price * 0.9))
      end
    end
  end

  def discounted
    total_savings = 0
    self.lines.each do |l|
      l.packages.each do |p|
        total_savings += (0.1 * p.price * p.expected_weight)
      end
    end
    total_savings
  end

  def packages
    packages = []
    self.lines.each do |l|
      l.packages.each do |p|
        packages << p
      end
    end
    packages
  end

  def get_difference
    total = 0
    self.packages.each do |p|
      total += (p.expected_weight - p.true_weight) * p.price
    end
    total
  end  

  def true_weight
    total = 0
    self.packages.each do |p|
      total += p.true_weight
    end
  end

  def real
    self.packages.each do |p|
      unless p.true_weight
        return false
      end
    end
    return true
  end

  def to_total
    unless self.total 
      total = 0
      self.packages.each do |p|
        total += p.expected_weight * p.price
      end
    end
    total
  end
  
end
