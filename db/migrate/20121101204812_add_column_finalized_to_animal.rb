class AddColumnFinalizedToAnimal < ActiveRecord::Migration
  def change
    add_column :animals, :finalized, :boolean, default: false
  end
end
