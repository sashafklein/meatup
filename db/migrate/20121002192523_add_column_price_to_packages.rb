class AddColumnPriceToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :price, :decimal
  end
end
