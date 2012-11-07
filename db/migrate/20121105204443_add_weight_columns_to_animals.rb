class AddWeightColumnsToAnimals < ActiveRecord::Migration
  def change
    add_column :animals, :hanging_weight, :float
    add_column :animals, :meat_weight, :float
  end
end
