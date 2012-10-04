class AddColumnCompToCuts < ActiveRecord::Migration
  def change
    add_column :cuts, :comp, :float
  end
end
