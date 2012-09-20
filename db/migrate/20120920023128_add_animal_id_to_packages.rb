class AddAnimalIdToPackages < ActiveRecord::Migration
  def change
  	add_column :packages, :animal_id, :integer
  end
end
