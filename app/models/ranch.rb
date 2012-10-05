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
#  cow_meat     :decimal(, )
#  pig_meat     :decimal(, )
#  lamb_meat    :decimal(, )
#  goat_meat    :decimal(, )
#  cow_hanging  :decimal(, )
#  pig_hanging  :decimal(, )
#  lamb_hanging :decimal(, )
#  goat_hanging :decimal(, )
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Ranch < ActiveRecord::Base
  attr_accessible :address, :cow, :cow_meat, :cow_hanging, :cow_live, :goat, :goat_meat, :goat_hanging, :goat_live, :lamb, :lamb_meat, :lamb_hanging, :lamb_live, :name, :phone, :pig, :pig_meat, :pig_hanging, :pig_live, :user_id
  has_many :animals
  after_save :defaults

  def defaults
    self.cow = false if self.cow != true
    self.pig = false if self.pig != true
    self.lamb = false if self.lamb != true
    self.goat = false if self.goat != true
  end

  def to_meat 
    if self.cow_meat == 0 || self.cow_meat == nil
      if self.cow_hanging != 0
        self.cow_meat = self.cow_hanging / CMOH
      elsif self.cow_live != 0
        self.cow_meat = self.cow_live / CMOL
      end
    
      if self.pig_hanging == 0
        self.pig_meat = self.pig_hanging / PMOH
      elsif self.pig_live != 0 
        self.pig_meat = self.pig_live / PMOL
      end
    
      if self.lamb_hanging != 0
        self.lamb_meat = self.lamb_hanging / LMOH
      elsif self.lamb_live != 0
        self.lamb_meat = self.lamb_live / LMOL
      end
      
      if self.goat_hanging != 0 
        self.goat_meat = self.goat_hanging / GMOH
      elsif self.goat_live != 0 
        self.goat_meat = self.goat_live / GMOL
      end
    end
  end
end
