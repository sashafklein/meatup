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
  delegate   :animal, to: :order, :allow_nil => true
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

  def target_packages
    animal.packages.where(cut_id: cut_id)
  end

  def decrement_packages
    target_packages.unsold.first(units).each do |package|
      package.update_attributes!(line_id: id, sold: true)
    end
  end

  def expected_weight
    self.cut.package_weight
  end

  def poundage
    packages.map(&:expected_weight).inject(:+)
  end

  def total
    packages.map(&:expected_revenue).inject(:+)
  end

  def price
    return packages.first.price if packages.any?
    1000
  end

  def processed_notes
    notes.blank? ? "None" : notes
  end

  def weight_diff
    packages.map(&:weight_diff).inject(:+)
  end

  def has_same_cut_and_notes_as(item)
    cut == item.cut && notes == item.notes
  end
end
