class AddRolesToUser < ActiveRecord::Migration
  def change
  	add_column :users, :is_host, :boolean, default: false
  	add_column :users, :is_rancher, :boolean, default: false
  	add_column :users, :is_butcher, :boolean, default: false
  end
end
