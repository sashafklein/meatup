class RemoveColumnLineIdFromCuts < ActiveRecord::Migration
  def change
    remove_column :cuts, :line_id
  end
end
