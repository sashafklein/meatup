class AddColumnNoSalesToAnimals < ActiveRecord::Migration
  def change
    add_column :animals, :no_sales, :boolean, :default => false
  end
end
