class Line < ActiveRecord::Base
  belongs_to :order
  attr_accessible :notes, :units, :order_id, :cut_id, :dependent => :destroy
  has_many :packages

  def cut
  	Cut.find(cut_id)
  end
end
