class AddColumnUserIdToHosts < ActiveRecord::Migration
  def change
    add_column :hosts, :user_id, :integer
  end
end
