class AddColumnButcherIdToAnimal < ActiveRecord::Migration
  def change
    add_column :animals, :butcher_id, :integer
  end
end
