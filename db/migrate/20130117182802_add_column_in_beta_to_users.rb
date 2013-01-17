class AddColumnInBetaToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :beta, :boolean, :default => true
  end
end
