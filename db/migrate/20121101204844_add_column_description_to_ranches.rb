class AddColumnDescriptionToRanches < ActiveRecord::Migration
  def change
    add_column :ranches, :description, :string
  end
end
