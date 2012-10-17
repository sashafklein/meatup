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
    puts "Delay bout to start"
    self.delay(:run_at => 1.minutes.from_now).check_payment
    puts "Delay action over"
  end

  def check_payment
    puts "Checking payment"
    self.reload
    if self.status == 0 
      puts "in check_payment, self.status confirmed as 0"
      self.roll_back
      puts "roll_back called"
    end
  end

  def roll_back
    puts "Doing rollback for #{self.id}"
    self.lines.each do |l|
      l.packages each do |p|
        p.update_attributes(:sold => false, :line_id => nil)
      end
    end
    self.destroy
  end

  # Returns the total poundage of a given order
  def poundage
    pounds = 0
    lines = self.slines
    lines.each do |l|
      pounds += l.units * l.cut.package_weight
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
        total += p.price * l.cut.package_weight
      end
    end
    return total
  end
  
end
