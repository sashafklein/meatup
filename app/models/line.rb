class Line < ActiveRecord::Base
  belongs_to :order
  attr_accessible :notes, :units, :order_id, :cut_id, :dependent => :destroy
  has_one :cut
  has_many :packages
end
