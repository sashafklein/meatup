class AddColumnLeftToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :left, :integer
  end
end
