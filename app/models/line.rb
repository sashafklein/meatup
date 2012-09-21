class Line < ActiveRecord::Base
  belongs_to :order
  attr_accessible :notes, :units, :dependent => :destroy
  has_one :cut
  has_many :packages
end
