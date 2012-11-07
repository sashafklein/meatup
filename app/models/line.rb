# == Schema Information
#
# Table name: lines
#
#  id         :integer          not null, primary key
#  units      :integer
#  notes      :string(255)
#  order_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cut_id     :integer
#

class Line < ActiveRecord::Base
  belongs_to :order
  attr_accessible :notes, :units, :order_id, :cut_id, :dependent => :destroy
  has_many :packages
  before_save :note_taker
  after_create :decrement_packages

  def cut
  	Cut.find(self.cut_id)
  end

  def note_taker 
    self.notes ||= ""
  end

  def decrement_packages
    a = self.order.animal
    cut_packages = a.packages.where(:cut_id => self.cut_id)
    unsold = cut_packages.where(:sold => false)
    unsold.first(self.units).each do |p|
      p.update_attribute(:line_id, self.id)
      p.toggle!(:sold)
    end
  end

  def expected_weight
    self.cut.package_weight
  end

  def poundage
    total = 0
    self.packages.each do |p|
      total += p.expected_weight
    end
    total
  end

  def total
    total = 0
    self.packages.each do |p|
      total += p.price * p.expected_weight
    end
    total
  end

  def price
    if self.packages.size > 0
      p = self.packages.first
      return p.price
    end
    1000
  end

  def processed_notes
    if self.notes == ""
      "None"
    else
      self.notes
    end
  end

  def weight_diff
    total = 0
    self.packages.each do |p|
      total += p.weight_diff
    end 
    total
  end
end
