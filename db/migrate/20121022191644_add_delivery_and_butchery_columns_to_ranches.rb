class AddDeliveryAndButcheryColumnsToRanches < ActiveRecord::Migration
  def change
  	add_column :ranches, :preferred_butcher, :integer
  	add_column :ranches, :has_csa, :boolean, default: false
  	add_column :ranches, :delivers_butcher, :boolean, default: false
  	add_column :ranches, :delivers_drop, :boolean, default: false
  	add_column :ranches, :delivers_host, :boolean, default: false
  	add_column :ranches, :cow_fixed, :integer, default: 0
  	add_column :ranches, :pig_fixed, :integer, default: 0
  	add_column :ranches, :lamb_fixed, :integer, default: 0
  	add_column :ranches, :goat_fixed, :integer, default: 0
  	change_column :ranches, :cow, :boolean, default: false
  	change_column :ranches, :pig, :boolean, default: false
  	change_column :ranches, :lamb, :boolean, default: false
  	change_column :ranches, :goat, :boolean, default: false
  end
end
