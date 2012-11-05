class ChangeOpeningSaleDefaultAgain < ActiveRecord::Migration
  def change
  	change_column :animals, :opening_sale, :boolean, default: true
  end
end
