# == Schema Information
#
# Table name: ranches
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  address           :string(255)
#  phone             :string(255)
#  user_id           :integer
#  cow               :boolean          default(FALSE)
#  pig               :boolean          default(FALSE)
#  lamb              :boolean          default(FALSE)
#  goat              :boolean          default(FALSE)
#  cow_live          :float
#  pig_live          :float
#  goat_live         :float
#  lamb_live         :float
#  cow_meat          :float
#  pig_meat          :float
#  lamb_meat         :float
#  goat_meat         :float
#  cow_hanging       :float
#  pig_hanging       :float
#  lamb_hanging      :float
#  goat_hanging      :float
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  state             :string(255)
#  zip               :string(255)
#  city              :string(255)
#  preferred_butcher :integer
#  has_csa           :boolean          default(FALSE)
#  delivers_butcher  :boolean          default(FALSE)
#  delivers_drop     :boolean          default(FALSE)
#  delivers_host     :boolean          default(FALSE)
#  cow_fixed         :integer          default(0)
#  pig_fixed         :integer          default(0)
#  lamb_fixed        :integer          default(0)
#  goat_fixed        :integer          default(0)
#  description       :string(255)
#

class Ranch < ActiveRecord::Base
  attr_accessible :address, :city, :state, :zip, :cow, :cow_meat, 
    :cow_hanging, :cow_live, :goat, :goat_meat, :goat_hanging, 
    :goat_live, :lamb, :lamb_meat, :lamb_hanging, :lamb_live, 
    :name, :phone, :pig, :pig_meat, :pig_hanging, :pig_live, 
    :user_id, :preferred_butcher, :has_csa, :delivers_butcher,
    :delivers_drop, :delivers_host, :cow_fixed, :pig_fixed, 
    :lamb_fixed, :goat_fixed

  has_many :animals
  belongs_to :user
  after_create :to_meat
  after_update :to_meat

  validates :zip, presence: true, length: {is: 5}
  validates :address, presence: true
  validates :state, presence: true
  validates :city, presence: true

  def to_meat 
    meat_types = %w( cow pig lamb goat)

    meat_types.each do |meat_type|
      replace_meat_price_with_hanging_or_live(meat_type) if !has_price_for?(meat_type, "meat")
    end
  end

  def replace_meat_price_with_hanging_or_live(meat_type)
    if has_price_for?(meat_type, "hanging")
      update_attribute "#{meat_type}_meat".to_sym, meat_from_hanging(meat_type)
    elsif has_price_for?(meat_type, "live")
      update_attribute "#{meat_type}_meat".to_sym, meat_from_live(meat_type)
    end
  end 

  def has_price_for?(meat_type, measurement)
    price = send("#{meat_type}_#{measurement}".to_sym)
    price.present? && price > 0
  end

  def meat_price(meat_type)
    send("#{meat_type}_meat".to_sym)
  end

  def hanging_price(meat_type)
    send("#{meat_type}_hanging".to_sym)
  end

  def live_price(meat_type)
    send("#{meat_type}_live".to_sym)
  end

  def ratio(type, first, second)
    Animal.weight_ratio(type, first, second)
  end

  def meat_from_hanging(meat_type)
    hanging_price(meat_type) / ratio(meat_type, "m", "h")
  end

  def meat_from_live(meat_type)
    live_price(meat_type) / ratio(meat_type, "m", "l")
  end

  def prices_for_animal(meat_type)
    {
      meat: meat_price(meat_type),
      hanging: hanging_price(meat_type),
      live: live_price(meat_type)
    }
  end

end
