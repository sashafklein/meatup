class AddExtraIdsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :butcher_id, :integer
  	add_column :users, :ranch_id, :integer
  	add_column :users, :host_id, :integer
  end
end
