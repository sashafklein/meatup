class AddColumnSoldToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :sold, :boolean
  end
end
