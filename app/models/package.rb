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
  attr_accessible :animal_id, :cut_id, :price, :line_id, :sold, :savings, :actual_lbs, :actual_oz, :true_weight
  attr_accessor :actual_lbs, :actual_oz
  belongs_to :animal
  belongs_to :cut
  belongs_to :line
  before_update :to_true

  scope :sold, where(:sold => true)
  scope :unsold, where(:sold => false)

  def expected_weight
  	self.cut.package_weight
  end

  def expected_packages
    self.animal.packages.where(:cut_id => self.cut.id)
  end

  def sold_packages
    self.animal.packages.where(:cut_id => self.cut.id).sold
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

  def user
    self.order.user
  end

  def identical_sold
    list = []
    self.animal.packages.where(:cut_id => self.cut_id).where(:sold => true).each do |p|
      list << p if p.line.notes == self.line.notes
    end
    list
  end

  def weight_diff
    if self.true_weight
      return self.true_weight - self.expected_weight
    end
    return self.expected_weight
  end

  def to_true
    puts "Pre-sold"
    if self.sold
      puts "First"
      if self.order.status == 1
        puts "Second"
        if self.true_weight.nil? || self.true_weight <= 0
          puts "First Unless"
          percent = self.actual_oz.to_f / 16
          puts self.actual_lbs.to_f + percent
          unless self.actual_lbs.to_f + percent == 0 
            puts "Last Unless"
            self.update_attribute(:true_weight, self.actual_lbs.to_f + percent)
          end
        end
      end
    end
  end

  def notes
    self.line.notes if self.sold
  end

  def finalized
    if self.order.status <= 1
      return false
    elsif self.order.status >= 2
      return true
    end
  end

  def actual_lbs=(val)
    true_weight_will_change!
    @actual_lbs=val
  end

end
