class AddColumnDifferenceToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :difference, :float
  end
end
