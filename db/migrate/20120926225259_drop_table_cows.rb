class DropTableCows < ActiveRecord::Migration
  def change
  	drop_table :cows
  end
end
