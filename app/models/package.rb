class Package < ActiveRecord::Base
  attr_accessible :animal_id, :cut_id, :number

  belongs_to :animal
  has_one :cut
end
