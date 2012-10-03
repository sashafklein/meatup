class RemoveColumnsFromPackages < ActiveRecord::Migration
  def up
    remove_column :packages, :original
    remove_column :packages, :left
  end

  def down
    add_column :packages, :left, :integer
    add_column :packages, :original, :integer
  end
end
