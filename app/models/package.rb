# == Schema Information
#
# Table name: packages
#
#  id          :integer          not null, primary key
#  cut_id      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  animal_id   :integer
#  price       :float
#  line_id     :integer
#  sold        :boolean
#  savings     :integer
#  true_weight :float
#

class Package < ActiveRecord::Base
  attr_accessible :animal_id, :cut_id, :price, :line_id, :sold, :savings, :actual_lbs, :actual_oz
  attr_accessor :actual_lbs, :actual_oz
  belongs_to :animal
  belongs_to :cut
  belongs_to :line
  # before_save :to_true

  def expected_weight
  	self.cut.package_weight
  end

  def expected_packages
  	animal = self.animal
  	number = animal.packages.where(:cut_id => self.cut.id)
  	number
  end

  def sold_packages
    animal = self.animal
    package_list = animal.packages.where(:cut_id => self.cut.id)
    sold = package_list.where(:sold => true)
    sold
  end

  # Fills an array with all the packages associated with a particular Cut and Prep Type
  def note_list
  	straight = []
  	ground = []
  	stew = []
  	boneless = []
  	complete = []
  	self.sold_packages.each do |p|
  		straight << p if p.line.notes == ""
  		ground << p if p.line.notes == "Ground"
  		stew << p if p.line.notes == "As Stew"
  		boneless << p if p.line.notes == "Deboned"
  	end	
  	straight.each do |s|
      complete << s
    end
    ground.each do |g|
      complete << g
    end
    stew.each do |s|
      complete << stew
    end
    boneless.each do |b|
      complete << b
    end
  	complete
  end

  def label_list
  	array = []
  	self.line.packages.each do |p|
  		array << p
  	end
  end

  def order
    self.line.order
  end

  def identical_sold
    list = []
    self.animal.packages.where(:cut_id => self.cut_id).where(:sold => true).each do |p|
      list << p if p.line.notes == self.line.notes
    end
    list
  end

  def weight_diff
    self.expected_weight - self.true_weight
  end

  def to_true
    self.update_attribute(:true_weight, self.actual_lbs + self.actual_oz/16)
  end

  def notes
    self.line.notes if self.sold
  end

end
