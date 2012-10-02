class RenameColumnVaccuumToVacuum < ActiveRecord::Migration
  def up
  	rename_column :butchers, :vaccuum_price, :vacuum_price
  end

  def down
  	rename_column :butchers, :vacuum_price, :vaccuum_price
  end
end
