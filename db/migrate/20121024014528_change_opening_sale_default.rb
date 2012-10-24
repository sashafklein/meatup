class ChangeOpeningSaleDefault < ActiveRecord::Migration
  def change
  	change_column :animals, :opening_sale, :boolean, default: false
  end
end
