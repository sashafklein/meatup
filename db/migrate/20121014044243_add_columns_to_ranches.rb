class AddColumnsToRanches < ActiveRecord::Migration
  def change
    add_column :ranches, :state, :string
    add_column :ranches, :zip, :string
  end
end
