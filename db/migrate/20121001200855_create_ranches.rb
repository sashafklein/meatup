class CreateRanches < ActiveRecord::Migration
  def change
    create_table :ranches do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.integer :user_id
      t.boolean :cow
      t.boolean :pig
      t.boolean :lamb
      t.boolean :goat
      t.decimal :cow_live
      t.decimal :pig_live
      t.decimal :goat_live
      t.decimal :lamb_live
      t.decimal :cow_carcass
      t.decimal :pig_carcass
      t.decimal :lamb_carcass
      t.decimal :goat_carcass
      t.decimal :cow_hanging
      t.decimal :pig_hanging
      t.decimal :lamb_hanging
      t.decimal :goat_hanging

      t.timestamps
    end
  end
end
