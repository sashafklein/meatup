class RenamePackagesNumberToOriginal < ActiveRecord::Migration
  def change
  	rename_column :packages, :number, :original
  end
end
