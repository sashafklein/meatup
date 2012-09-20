class RemoveCowIdFromPackages < ActiveRecord::Migration
  def up
  	remove_column :packages, :cow_id
  end

  def down
  	add_column :packages, :cow_id, :integer
  end
end
