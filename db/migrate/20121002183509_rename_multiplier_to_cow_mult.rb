class RenameMultiplierToCowMult < ActiveRecord::Migration
  def up
  	rename_column :animals, :multiplier, :cow_mult
  end

  def down
  	rename_column :animals, :cow_mult, :multiplier
  end
end
