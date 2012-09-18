class Order < ActiveRecord::Base
  belongs_to :user
  attr_accessible :status, :lines_attributes

  has_many :lines

  accepts_nested_attributes_for :lines
end
