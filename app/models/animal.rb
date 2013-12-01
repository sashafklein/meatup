# == Schema Information
#
# Table name: animals
#
#  id                   :integer          not null, primary key
#  animal_type          :string(255)
#  name                 :string(255)
#  breed                :string(255)
#  weight               :integer
#  photo                :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  ranch_id             :integer
#  butcher_id           :integer
#  host_id              :integer
#  open                 :boolean          default(TRUE)
#  finalized            :boolean          default(FALSE)
#  hanging_weight       :float
#  meat_weight          :float
#  no_sales             :boolean          default(FALSE)
#  conduct_opening_sale :boolean          default(FALSE)
#  conduct_final_sale   :boolean          default(FALSE)
#  on_opening_sale      :boolean          default(FALSE)
#  on_final_sale        :boolean          default(FALSE)
#  price_multiplier     :float            default(1.0)
#

class Animal < ActiveRecord::Base
  attr_accessible :breed, :name, :photo, :animal_type, :hanging_weight, :meat_weight,  
                  :weight, :ranch_id, :butcher_id, :packages_attributes, :host_id, :open, 
                  :no_sales, :conduct_opening_sale, :conduct_final_sale, :on_opening_sale, 
                  :on_final_sale, :price_multiplier
                  
  has_many :orders
  has_many :packages, through: :lines
  has_many :real_cuts
  has_many :lines, through: :orders
  belongs_to :butcher
  belongs_to :ranch
  belongs_to :host
  
  after_create do 
    create_real_cuts!
  end

  class AnimalError < StandardError; end

  delegate  :downpaid_total, :downpaid_pounds, :paid_total, :paid_pounds, :paid_orders, 
            :revenue_made, :revenue_possible, :profit, :best_lb_estimate, :expected_margins, 
            :pounds_sold, :pounds_left, :percent_left, :weight_ratio, :butcher_final_price, 
            to: :calculator

  before_create { animal_type.downcase! }

  accepts_nested_attributes_for :packages

  validates :weight, presence: true
  validates :breed, presence: true
  validates :animal_type, presence: true

  scope :on_sale, -> { where(open: true) }

  ## Major Action Methods
  #################

  def create_real_cuts!
    platonic_cuts.each do |cut|
      RealCut.create_from!(self, cut)
    end
  end

  ## Minor Action Methods
  ######################

  def close_animal!
    update_attribute(:open, false)
    notify_users_of_animal_close
  end
  
  ## Bundler
  ################

  def bundle_for
    AnimalBundler.new(self)
  end


  ## Cut Methods
  ##############
  def platonic_cuts
    Cut.where(animal_type: animal_type)
  end

  def sold_out_cuts
    real_cuts.sold_out
  end

  def available_cuts
    real_cuts.available
  end

  def sold_out_of?(cut)
    real = real(cut)
    real.expected_units <= real.sold_units
  end 

  def real(cut)
    real_cuts.find_by_cut_id(cut.id)
  end

  def real_by_name(name)
    real(Cut.find_by_name(name))
  end

  def sold_cuts
    real_cuts.touched
  end

  ## Package Methods
  ##################

  def check_for_sold!
    close_animal! if all_sold?
  end

  ## User Methods
  ###################

  def unweighed?
    !hanging_weight || !meat_weight
  end

  def mult
    price_multiplier
  end

  def harvest_date
    "TBD"
  end

  def pickup_date
    name == "Donald Trump" ? "January 12th" : "TBD"
  end

  def calculator
    AnimalCalc.new(self)
  end

  ## MISC
  #######################

  def meat_type
    AnimalType.new(animal_type).meat
  end

  def weight_multiplier
    1
  end

  private

  def purchaser_ids
    orders.pluck(:user_id).uniq
  end

  def type?(string)
    animal_type == string
  end

  def sale
    AnimalSale.new(self).sale
  end
  
  def all_sold?
    real_cuts.sum(:expected_units) <= real_cuts.sum(:sold_units)
  end

  def notify_users_of_animal_close
    UserMailer.animal_close(self).deliver if !host.user.has_meatup_address?
    User.admins.reject(&:has_meatup_address?).each { |u| UserMailer.animal_overview(self).deliver }
    UserMailer.butcher_specs(self).deliver unless butcher.user.has_meatup_address?
  end


  def hanging_weight
    weight * weight_ratio("hanging", "live")
  end
end
