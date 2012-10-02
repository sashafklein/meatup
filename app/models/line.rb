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
  attr_accessible :notes, :units, :order_id, :cut_id, :ground, :stew, :boneless, :dependent => :destroy
  attr_accessor :ground, :stew, :boneless
  has_many :packages
  after_create :decrement_packages

  before_save :to_notes

  def decrement_packages
  	@p = Package.find_by_cut_id_and_animal_id(self.cut_id, self.order.animal_id)
  	@p.left = @p.left - self.units
  	@p.save!
  end

  def cut
  	Cut.find(cut_id)
  end

  def to_notes
    if self.ground == 1
      self.notes = "Ground"
    elsif self.stew == 1
      self.notes = "Stew"
    elsif self.boneless == 1
      self.notes = "Boneless"
    end
  end
end
