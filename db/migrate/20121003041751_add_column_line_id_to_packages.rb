class AddColumnLineIdToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :line_id, :integer
  end
end
