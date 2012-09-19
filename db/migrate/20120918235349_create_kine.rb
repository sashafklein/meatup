class CreateKine < ActiveRecord::Migration
  def change
    create_table :kine do |t|
      t.string :name
      t.string :farm
      t.string :host
      t.integer :weight
      t.string :breed
      t.string :photo

      t.timestamps
    end
  end
end
