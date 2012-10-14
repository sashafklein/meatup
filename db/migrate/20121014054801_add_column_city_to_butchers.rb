class AddColumnCityToButchers < ActiveRecord::Migration
  def change
    add_column :butchers, :city, :string
  end
end
