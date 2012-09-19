class RenameKineToCows < ActiveRecord::Migration
  def self.up
  	rename_table :kine, :cows
  end

  def self.down
  	rename_table :cows, :kine
  end
end
