# == Schema Information
#
# Table name: lines
#
#  id         :integer          not null, primary key
#  units      :integer
#  notes      :string(255)      default("")
#  order_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cut_id     :integer
#

class Line < ActiveRecord::Base

  attr_accessible :notes, :units, :order_id, :cut_id, :dependent => :destroy
  
  belongs_to :order
  belongs_to :cut
  has_many   :packages
  delegate   :animal, to: :order, :allow_nil => true

  class LineError < StandardError; end

  def self.create_lines_and_decrement_packages(new_lines, new_order)
    new_lines.each do |line|
      if new_line = new_order.lines.create!(cut_id: line[:cut_id], units: line[:units], notes: line[:notes])
        new_line.decrement_packages(line[:sale_price])
      else
        raise LineError.new "Line failed be created! Lines: #{new_lines}, Order: #{new_order.inspect}"
      end
    end
  end

  def decrement_packages(sale_price)
    hash = { line_id: id, sold: true, price: sale_price }
    target_packages.unsold.first(units).each do |package|
      true_weight = Rails.env.production? ? nil : package.expected_weight
      new_hash = hash.merge({ true_weight: true_weight })

      unless package.update_attributes!(new_hash)
        raise LineError.new "Line failed to decrement packages. Line: #{self.inspect}, Hash: #{new_hash}"
      end
    end
  end

  def cut
  	Cut.find(self.cut_id)
  end

  def target_packages
    animal.packages.where(cut_id: cut_id)
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

  private

  def sale_price
    AnimalCut.new(animal, cut).list_price
  end
end
