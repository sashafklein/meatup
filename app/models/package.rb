class Package < ActiveRecord::Base
  attr_accessible :animal_id, :cut_id, :original, :left

  belongs_to :animal
  has_one :cut
end
