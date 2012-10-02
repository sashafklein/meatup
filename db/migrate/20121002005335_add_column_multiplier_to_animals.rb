class AddColumnMultiplierToAnimals < ActiveRecord::Migration
  def change
    add_column :animals, :multiplier, :decimal
  end
end
