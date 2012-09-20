class CreateAnimals < ActiveRecord::Migration
  def change
    create_table :animals do |t|
      t.string :type
      t.string :name
      t.string :breed
      t.integer :weight
      t.string :farm
      t.string :host
      t.string :photo

      t.timestamps
    end
  end
end
