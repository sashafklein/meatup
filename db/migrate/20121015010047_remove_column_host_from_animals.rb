class RemoveColumnHostFromAnimals < ActiveRecord::Migration
  def up
    remove_column :animals, :host
  end

  def down
    add_column :animals, :host, :string
  end
end
