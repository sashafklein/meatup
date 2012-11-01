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
  after_create :to_meat
  after_update :to_meat

  validates :zip, presence: true, length: {is: 5}
  validates :address, presence: true
  validates :state, presence: true
  validates :city, presence: true

  def to_meat 
    if self.cow_meat == 0 || self.cow_meat == nil
      if self.cow_hanging != nil && self.cow_hanging != 0
        self.update_attribute(:cow_meat, self.cow_hanging / CMOH)
      elsif self.cow_live != nil && self.cow_live != 0
        self.update_attribute(:cow_meat, self.cow_live / CMOL)
      end
    end
    
    if self.pig_meat == 0 || self.pig_meat == nil
      if self.pig_hanging != nil && self.pig_hanging != 0
        self.update_attribute(:pig_meat, self.pig_hanging / CMOH)
      elsif self.pig_live != nil && self.pig_live != 0
        self.update_attribute(:pig_meat, self.pig_live / CMOL)
      end
    end

    if self.lamb_meat == 0 || self.lamb_meat == nil
      if self.lamb_hanging != nil && self.lamb_hanging != 0
        self.update_attribute(:lamb_meat, self.lamb_hanging / CMOH)
      elsif self.lamb_live != nil && self.lamb_live != 0
        self.update_attribute(:lamb_meat, self.lamb_live / CMOL)
      end
    end

    if self.goat_meat == 0 || self.goat_meat == nil
      if self.goat_hanging != nil && self.goat_hanging != 0
        self.update_attribute(:goat_meat, self.goat_hanging / CMOH)
      elsif self.goat_live != nil && self.goat_live != 0
        self.update_attribute(:goat_meat, self.goat_live / CMOL)
      end
    end
  end

end
