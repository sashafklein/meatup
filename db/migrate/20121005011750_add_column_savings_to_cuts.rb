class AddColumnSavingsToCuts < ActiveRecord::Migration
  def change
    add_column :cuts, :savings, :integer
  end
end
