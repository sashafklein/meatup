class AddColumnHostIdToAnimals < ActiveRecord::Migration
  def change
    add_column :animals, :host_id, :integer
  end
end
