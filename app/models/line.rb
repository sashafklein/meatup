class Line < ActiveRecord::Base
  belongs_to :order
  attr_accessible :notes, :units, :dependent => :destroy
end
