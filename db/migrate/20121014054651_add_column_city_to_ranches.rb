class AddColumnCityToRanches < ActiveRecord::Migration
  def change
  	add_column :ranches, :city, :string
  end
end
