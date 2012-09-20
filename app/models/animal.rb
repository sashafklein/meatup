class Animal < ActiveRecord::Base
  attr_accessible :breed, :farm, :host, :name, :photo, :type, :weight
end
