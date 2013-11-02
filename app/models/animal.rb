# == Schema Information
#
# Table name: animals
#
#  id             :integer          not null, primary key
#  animal_type    :string(255)
#  name           :string(255)
#  breed          :string(255)
#  weight         :integer
#  photo          :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  ranch_id       :integer
#  butcher_id     :integer
#  cow_mult       :float
#  pig_mult       :float
#  lamb_mult      :float
#  goat_mult      :float
#  host_id        :integer
#  open           :boolean          default(TRUE)
#  finalized      :boolean          default(FALSE)
#  hanging_weight :float
#  meat_weight    :float
#  no_sales       :boolean          default(FALSE)
#

class Animal < ActiveRecord::Base
  attr_accessible :breed, :name, :photo, :animal_type, :hanging_weight, :meat_weight,  
                  :weight, :ranch_id, :butcher_id, :cow_mult, :pig_mult, :packages_attributes,
                  :lamb_mult, :goat_mult, :host_id, :open, :no_sales, :conduct_opening_sale,
                  :conduct_final_sale, :on_opening_sale, :on_final_sale, :price_multiplier
                  
  has_many :orders
  has_many :packages
  has_many :lines, through: :orders
  belongs_to :butcher
  belongs_to :ranch
  belongs_to :host
  
  after_create do 
    if !Rails.env.test?
      create_packages!
    end
  end

  delegate  :downpaid_total, :downpaid_pounds, :paid_total, :paid_pounds, :paid_orders, :revenue_made, 
            :revenue_possible, :wholesale_cost, :profit, :left_to_make, :avg_price, :avg_weight, :pounds_total, 
            :pounds_sold, :pounds_left, :percent_left , :best_lb_estimate, :expected_margins , :ranch_price, 
            :weight_ratio, :fixed_price, :butcher_final_price, 
            to: :calculator

  before_create { animal_type.downcase! }

  accepts_nested_attributes_for :packages

  validates :weight, presence: true
  validates :breed, presence: true
  validates :animal_type, presence: true

  scope :on_sale, -> { where(open: true) }

  ## Major Action Methods
  #################

  def create_cut_packages!(cut)
    animal_cut = AnimalCut.new(cut, self)
    cut_price = animal_cut.starting_price
    cut_savings = animal_cut.generate_savings(cut_price)

    cut.number_of_packages_for_animal(weight).times do 
      create_package_for_cut!(cut: cut, cut_price: cut_price, cut_savings: cut_savings)
    end
  end

  def create_package_for_cut!(hash={})
    Package.create!(
      animal_id: id,
      cut_id: hash[:cut].id,
      price: hash[:cut_price],
      sold: false,
      savings: hash[:cut_savings]
    )
  end

  def create_packages!
    cuts.each{ |cut| create_cut_packages!(cut) }
    
    sale = AnimalSale.new(self).sale
    sale.move! if sale.move?
  end

  ## Minor Action Methods
  ######################

  def all_sold?
    packges.unsold.size == 0
  end

  def close_animal
    update_attribute(:open, false)
    notify_users_of_animal_close
  end

  def notify_users_of_animal_close
    UserMailer.animal_close(self).deliver if !host.user.has_meatup_address?
    User.admins.reject(&:has_meatup_address?).each { |u| UserMailer.animal_overview(self).deliver }
    UserMailer.butcher_specs(self).deliver unless butcher.user.has_meatup_address?
  end

  def start_final_sale!
    AnimalSale.new(animal, 'final').start_sale!
  end

  def finalize
    return false if finalized?
    update_attribute(:finalized, true)
  end

  
  ## Bundler
  ################

  def bundle_for
    AnimalBundler.new(self)
  end


  ## Cut Methods
  ##############
  def cuts
    AnimalCut.new(nil, self).all
  end

  def sold_out_cuts
    AnimalCut.new(nil, self).sold_out
  end

  def available_cuts
    AnimalCut.new(nil, self).available
  end

  def sold_out_of?(cut)
    AnimalCut.new(cut, self).sold_out?
  end 


  ## Package Methods
  ##################

  def packages_for(cut)
    AnimalCut.new(cut, self).packages
  end

  def sold(cut)
    packages_for(cut).where(:sold => true)
  end

  def check_for_sold
    close_animal if all_sold?
  end

  ## User Methods
  ###################

  def purchasers
    User.where(id: purchaser_ids)
  end

  def hanging_weight
    weight * weight_ratio("hanging", "meat")
  end

  def mult
    price_multiplier
  end

  def harvest_date
    "TBD"
  end

  def butchery_date
    "TBD"
  end

  def pickup_date
    name == "Donald Trump" ? "January 12th" : "TBD"
  end

  def calculator
    AnimalCalc.new(self)
  end

  def all_finalized
    packages.count == packages.complete.count + packages.paid.count
  end

  def meat_type
    AnimalType.new(animal_type).meat
  end

  private

  def purchaser_ids
    orders.pluck(:user_id).uniq
  end

end
