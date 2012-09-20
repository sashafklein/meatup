class RenameTypeColumn < ActiveRecord::Migration
  def self.up
    rename_column :animals, :type, :animal_type
  end

  def self.down
    rename_column :animals, :animal_type, :type
  end
end

