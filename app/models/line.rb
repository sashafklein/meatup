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

  attr_accessible :notes, :units, :order_id, :real_cut_id, :sale_price, :dependent => :destroy
  
  belongs_to :order
  belongs_to :real_cut
  has_many   :packages
  delegate   :animal, to: :order, :allow_nil => true
  delegate   :cut_id, to: :real_cut

  after_create :create_packages!

  scope :weighed, -> { merge(Package.weighed) }
  scope :unweighed, -> { merge(Package.unweighed) }

  class LineError < StandardError; end

  def self.create_from_cleaned!(new_lines, order)
    new_lines.each{ |l| order.lines.create!(l) }
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

  def cut
  	Cut.find(cut_id)
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

  def revenue
    weighed? ? weighed_revenue : unweighed_revenue
  end

  def pounds
    weighed? ? weighed_pounds : unweighed_pounds
  end

  def unweighed_pounds
    units * real_cut.weight
  end

  def weighed_pounds
    packages.sum(:true_weight)
  end

  def unweighed_revenue
    sale_price * unweighed_pounds
  end

  def weighed_revenue
    sale_price * weighed_pounds
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

  def weighed?
    packages.pluck(:true_weight).all?
  end
end
