class AddAnimalIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :animal_id, :integer
  end
end
