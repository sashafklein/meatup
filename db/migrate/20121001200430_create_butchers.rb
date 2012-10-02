class CreateButchers < ActiveRecord::Migration
  def change
    create_table :butchers do |t|
      t.string :name
      t.string :address
      t.decimal :hanging_price
      t.decimal :final_price
      t.decimal :vaccuum_price
      t.decimal :wrap_price
      t.string :phone
      t.integer :user_id
      t.boolean :ground
      t.boolean :stew
      t.boolean :boneless

      t.timestamps
    end
  end
end
