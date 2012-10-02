class AddColumnsToAnimals < ActiveRecord::Migration
  def change
    add_column :animals, :pig_mult, :decimal
    add_column :animals, :lamb_mult, :decimal
    add_column :animals, :goat_mult, :decimal
  end
end
