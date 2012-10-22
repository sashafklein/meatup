class AddSaleColumnsToAnimals < ActiveRecord::Migration
  def change
    add_column :animals, :final_sale, :boolean, default: false
    add_column :animals, :opening_sale, :boolean, default: true
  end
end
