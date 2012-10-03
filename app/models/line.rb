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
  	Cut.find(cut_id)
  end

  def note_taker 
    self.notes ||= ""
  end

  def decrement_packages
    ps_left = self.cut.packages.where(:sold == false)
    ps = p_left.first(self.units)
    ps.each do |p|
      p.line_id = self.line_id
      p.sold = true
      p.save
    end
  end

end
