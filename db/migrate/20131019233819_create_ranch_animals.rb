class CreateRanchAnimals < ActiveRecord::Migration
  def change
    create_table :ranch_animals do |t|
      t.string :animal_type
      t.float :meat_price, default: nil
      t.float :hanging_price, default: nil
      t.float :live_price, default: nil
      t.float :fixed_cost, default: 0
      t.integer :ranch_id

      t.timestamps
    end
  end
end
