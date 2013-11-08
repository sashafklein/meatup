class AddDefaultToRealCuts < ActiveRecord::Migration
  def change
    change_column :real_cuts, :sold_units, :integer, default: 0
  end
end
