class AddColumnRanchIdToAnimal < ActiveRecord::Migration
  def change
  	add_column :animals, :ranch_id, :integer
  end
end
