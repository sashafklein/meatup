class AddColumnZipToHosts < ActiveRecord::Migration
  def change
    add_column :hosts, :zip, :string
  end
end
