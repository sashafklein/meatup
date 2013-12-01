class RemoveColumnApologyFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :apology
  end
end
