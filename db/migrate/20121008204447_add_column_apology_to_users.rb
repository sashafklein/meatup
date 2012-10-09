class AddColumnApologyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :apology, :boolean
  end
end
