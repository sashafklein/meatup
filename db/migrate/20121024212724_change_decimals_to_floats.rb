class ChangeDecimalsToFloats < ActiveRecord::Migration
  def change
  	change_column :animals, :cow_mult, :float
  	change_column :animals, :pig_mult, :float
  	change_column :animals, :lamb_mult, :float
  	change_column :animals, :goat_mult, :float

  	change_column :packages, :price, :float

  	change_column :ranches, :cow_live, :float
  	change_column :ranches, :pig_live, :float
  	change_column :ranches, :lamb_live, :float
  	change_column :ranches, :goat_live, :float
  	change_column :ranches, :cow_meat, :float
  	change_column :ranches, :pig_meat, :float
  	change_column :ranches, :lamb_meat, :float
  	change_column :ranches, :goat_meat, :float
  	change_column :ranches, :cow_hanging, :float
  	change_column :ranches, :pig_hanging, :float
  	change_column :ranches, :lamb_hanging, :float
  	change_column :ranches, :goat_hanging, :float

  end
end
