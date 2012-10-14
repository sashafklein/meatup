class AddColumnsToButchers < ActiveRecord::Migration
  def change
    add_column :butchers, :state, :string
    add_column :butchers, :zip, :string
  end
end
