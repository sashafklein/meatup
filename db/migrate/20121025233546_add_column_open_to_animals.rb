class AddColumnOpenToAnimals < ActiveRecord::Migration
  def change
    add_column :animals, :open, :boolean, default: true
  end
end
