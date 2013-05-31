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
  	cut.package_weight
  end

  def expected_packages
    animal.packages.where(:cut_id => cut.id)
  end

  def sold_packages
    animal.packages.where(:cut_id => cut.id).sold
  end

  # Fills an array with all the packages associated with a particular Cut and Prep Type
  def note_list
  	straight = []
  	ground = []
  	stew = []
  	boneless = []
  	complete = []
  	sold_packages.each do |p|
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
  	line.packages.each do |p|
  		array << p
  	end
    array
  end

  def order
    line.order
  end

  def user
    order.user
  end

  def identical_sold
    animal.packages.where(:cut_id => cut_id).where(:sold => true).select{ |p| p.line.notes == line.notes }
  end

  def weight_diff
    true_weight ? true_weight - expected_weight : expected_weight
  end

  def to_true
    puts "Pre-sold"
    if sold && order.status == 1
      if true_weight.nil? || true_weight <= 0
        percent = actual_oz.to_f / 16
        unless actual_lbs.to_f + percent == 0 
          update_attribute(:true_weight, actual_lbs.to_f + percent)
        end
      end
    end
  end

  def notes
    line.notes if sold
  end

  def finalized
    order.status < 2 ? false : true
  end

  def actual_lbs=(val)
    true_weight_will_change!
    @actual_lbs=val
  end

end
