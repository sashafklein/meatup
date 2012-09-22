class ChangePackageToPackageWeight < ActiveRecord::Migration
  def up
  	rename_column :cuts, :package, :package_weight
  end

  def down
  	rename_column :cuts, :package_weight, :package
  end
end
