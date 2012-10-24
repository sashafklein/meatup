class AddColumnDescriptionToCuts < ActiveRecord::Migration
  def change
    add_column :cuts, :description, :text
  end
end
