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

  attr_accessible :notes, :units, :order_id, :cut_id, :dependent => :destroy
  
  belongs_to :order
  belongs_to :cut
  has_many :packages
  delegate   :animal, to: :order, :allow_nil => true
  
  after_create :decrement_packages

  def self.in_cut_and_note_bundles
    bundles = group_by{ |line| [line.cut.name, line.notes] }.sort
    bundles.map do |line_group|
      OpenStruct.new(
        cut_name: line_group[0][0], 
        notes: line_group[0][1],
        number: line_group[1]
      )
    end
  end

  def cut
  	Cut.find(self.cut_id)
  end

  def target_packages
    animal.packages.where(cut_id: cut_id)
  end

  def decrement_packages
    if !Rails.env.production?
      target_packages.unsold.first(units).each do |package|
        package.update_attributes!(line_id: id, sold: true, true_weight: package.expected_weight)
      end
    else
      target_packages.unsold.first(units).each do |package|
        package.update_attributes!(line_id: id, sold: true)
      end
    end
  end

  def expected_weight
    self.cut.package_weight
  end

  def real_weight
    return nil if packages.pluck(:true_weight).include?(nil)
    packages.pluck(:true_weight).sum
  end

  def weight_diff
    real_weight ? expected_weight - real_weight : nil
  end

  def poundage
    packages.map(&:fallback_weight).sum
  end

  def total
    packages.map(&:fallback_revenue).sum
  end

  def price
    return packages.first.price if packages.any?
    1000
  end

  def processed_notes
    notes.blank? ? "None" : notes
  end

  def has_same_cut_and_notes_as(item)
    cut == item.cut && notes == item.notes
  end
end
