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
#  final_sale     :boolean          default(FALSE)
#  opening_sale   :boolean          default(TRUE)
#  open           :boolean          default(TRUE)
#  finalized      :boolean          default(FALSE)
#  hanging_weight :float
#  meat_weight    :float
#  no_sales       :boolean          default(FALSE)
#

class Animal < ActiveRecord::Base
  attr_accessible :breed, :name, :photo, :animal_type, :hanging_weight, :meat_weight,  
                  :weight, :ranch_id, :butcher_id, :cow_mult, :pig_mult, :packages_attributes,
                  :lamb_mult, :goat_mult, :host_id, :final_sale, :opening_sale, :open, :no_sales
  has_many :orders
  has_many :packages
  has_many :lines, through: :orders
  belongs_to :butcher
  belongs_to :ranch
  belongs_to :host
  
  after_create do 
    if !Rails.env.test?
      create_packages
      start_opening_sale
    end
  end

  before_create { animal_type.downcase! }

  accepts_nested_attributes_for :packages

  validates :weight, presence: true
  validates :breed, presence: true
  validates :animal_type, presence: true

  scope :open, -> { where(open: true) }

  def meat_type
    AnimalType.new(animal_type).meat
  end

  def cutlist
    Cut.where(animal_type: animal_type).weighted
  end

  def create_packages
  	cutlist.each{ |cut| create_cut_packages(cut) }
  end

  def package_price(cut)
    cut.incentive ? cut.price * 0.9 : cut.price
  end

  def create_cut_packages(cut)
    cut.number_of_packages_for_animal(weight).times do 
      create_package_for_cut(cut)
    end
  end

  def create_package_for_cut(cut)
    Package.create!(
      animal_id: id,
      cut_id: cut.id,
      price: cut.package_price,
      sold: false,
      savings: cut.savings
    )
  end

  def cut_find
	 Cut.where(:animal_type => animal_type)
  end

  def best_lb_estimate
    packages.map(&:fallback_weight).inject(:+)
  end

  def pounds_total
    packages.map(&:expected_weight).inject(:+)
  end

  def pounds_sold
    packages.sold.map(&:fallback_weight).inject(:+)
  end

  def pounds_left
    pounds_total - pounds_sold
  end 


  def percent_left
    (100 * pounds_left) / pounds_total
  end  

  def start_opening_sale
    if !no_sales && opening_sale
      delay(:run_at => 120.minutes.from_now).end_opening_sale
    end
  end

  def end_opening_sale
    return false unless opening_sale

    packages.unsold.incentivized.each { |package| package.remove_from_opening_sale }
    update_attribute(:opening_sale, false)
  end

  def start_final_sale
    return false if no_sales
    end_opening_sale if opening_sale

    packages.unsold.each { |package| package.start_final_sale }
    update_attribute(:final_sale, true)
  end

  def cut_packages(cut)
    Package.where(:animal_id => id).where(:cut_id => cut.id)
  end

  def sold(cut)
    cut_packages(cut).where(:sold => true)
  end

  def cut_unsold(cut)
    cut_packages(cut).where(:sold => false)
  end

  def revenue_made
    packages.sold.map(&:real_revenue).sum || 0
  end

  def revenue_possible
    packages.map(&:expected_revenue).sum
  end

  def profit
    revenue_made - wholesale_cost
  end

  def left_to_make
    revenue_possible - revenue_made
  end

  # Returns total cost (for meat, butchery, and fixed, for the given animal)

  def ranch_price(measurement)
    ranch.info_for(animal_type).price(measurement)
  end

  def weight_ratio(first, second)
    WeightRatio.new(animal_type).ratio(first, second)
  end

  def fixed_price
    ranch_price(:fixed)
  end

  def butcher_final_price
    butcher.final_price ? butcher.final_price : 0
  end

  def wholesale_cost
    ranch_price(:meat) * weight_ratio(:meat, :live) * weight + fixed_price + butcher_final_price
  end

  def expected_margins 
    revenue_possible - wholesale_cost
  end

  def check_for_sold
    close_animal if all_sold?
  end

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

  def full_cut_table
    ItemBundler.new(packages).in_bundles_by_cut
  end

  def list_for_sale
    ItemBundler.new(packages).by_cut_sale_and_savings
  end

  # Array of Open Structs with "bundles" of unique (cut/notes) lines
  def make_sold_list
    ItemBundler.new(lines).in_cut_and_note_bundles
  end

  # Array of Open Structs with "bundles" of unique (cut/notes) packages
  def sold_bundles 
    ItemBundler.new(packages).sold_in_line_note_bundles
  end

  def sold_out_of?(cut)
    cut_packages.all?(&:sold)
  end

  # Array of Open Structs associating users with the packages they purchase of this animal
  def user_order_list
    purchasers.map{ |u| OpenStruct.new(user: u, packages: u.associated_packages) }
  end

  def hanging_weight
    weight * weight_ratio("hanging", "meat")
  end

  # Returns full list of the users who bought from the animal
  def purchasers
    user_ids = orders.pluck(:user_id).uniq
    User.where(id: user_ids)
  end

  def mult
    send("#{animal_type.downcase}_mult".to_sym)
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

  def downpaid_total
    packages.with_order_status(:downpaid).map(&:expected_revenue).sum
  end

  def downpaid_pounds
    packages.with_order_status(:downpaid).map(&:expected_weight).sum
  end

  def paid_total
    packages.with_order_status(:paid).map(&:paid_revenue).sum
  end

  def paid_pounds
    packages.with_order_status(:paid).map(&:fallback_weight).sum
  end

  def paid_orders
    orders.paid
  end

  def avg_price
    revenue_possible / pounds_total
  end

  def avg_weight
    pounds_total / packages.size
  end

  def all_finalized
    packages.count == packages.complete.count + packages.paid.count
  end

  def finalize
    return false if finalized?
    update_attribute(:finalized, true)
  end

end
