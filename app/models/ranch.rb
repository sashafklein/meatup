# == Schema Information
#
# Table name: ranches
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  address      :string(255)
#  phone        :string(255)
#  user_id      :integer
#  cow          :boolean
#  pig          :boolean
#  lamb         :boolean
#  goat         :boolean
#  cow_live     :decimal(, )
#  pig_live     :decimal(, )
#  goat_live    :decimal(, )
#  lamb_live    :decimal(, )
#  cow_carcass  :decimal(, )
#  pig_carcass  :decimal(, )
#  lamb_carcass :decimal(, )
#  goat_carcass :decimal(, )
#  cow_hanging  :decimal(, )
#  pig_hanging  :decimal(, )
#  lamb_hanging :decimal(, )
#  goat_hanging :decimal(, )
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Ranch < ActiveRecord::Base
  attr_accessible :address, :cow, :cow_carcass, :cow_hanging, :cow_live, :goat, :goat_carcass, :goat_hanging, :goat_live, :lamb, :lamb_carcass, :lamb_hanging, :lamb_live, :name, :phone, :pig, :pig_carcass, :pig_hanging, :pig_live, :user_id
  before_save :default_values

  has_many :animals

  def default_values
    self.cow ||= false
    self.pig ||= false
    self.lamb ||= false
    self.goat ||= false
    self.cow_hanging ||= 0
    self.pig_hanging ||= 0
    self.goat_hanging ||= 0
    self.lamb_hanging ||= 0
    self.cow_live ||= 0
    self.pig_live ||= 0
    self.lamb_live ||= 0
    self.goat_live ||= 0
    self.cow_carcass ||= 0
    self.pig_carcass ||= 0
    self.lamb_carcass ||= 0
    self.goat_carcass ||= 0
    self.phone ||= "None"
  end
end
