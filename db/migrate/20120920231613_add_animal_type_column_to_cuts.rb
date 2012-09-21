class AddAnimalTypeColumnToCuts < ActiveRecord::Migration
  def change
  	add_column :cuts, :animal_type, :string
  end
end
