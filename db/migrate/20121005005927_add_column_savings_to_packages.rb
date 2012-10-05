class AddColumnSavingsToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :savings, :integer
  end
end
