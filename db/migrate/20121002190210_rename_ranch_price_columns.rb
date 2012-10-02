class RenameRanchPriceColumns < ActiveRecord::Migration
  def up
  	rename_column :ranches, :cow_carcass, :cow_meat
  	rename_column :ranches, :pig_carcass, :pig_meat
  	rename_column :ranches, :lamb_carcass, :lamb_meat
  	rename_column :ranches, :goat_carcass, :goat_meat
  end

  def down
  	rename_column :ranches, :cow_meat, :cow_carcass
  	rename_column :ranches, :pig_meat, :pig_carcass
  	rename_column :ranches, :lamb_meat, :lamb_carcass
  	rename_column :ranches, :goat_meat, :goat_carcass
  end
end
