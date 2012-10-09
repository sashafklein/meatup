class RemoveColumnFarmFromAnimals < ActiveRecord::Migration
  def up
  	remove_column :animals, :farm
  end

  def down
  	add_column :animals, :farm, :string
  end
end
