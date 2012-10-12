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
  belongs_to :order, :dependent => :destroy
  attr_accessible :notes, :units, :order_id, :cut_id, :dependent => :destroy
  has_many :packages
  before_save :note_taker
  after_create :decrement_packages

  def cut
  	Cut.find(cut_id)
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

end
