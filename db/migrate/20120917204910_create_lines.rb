class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.integer :units
      t.string :notes
      t.references :order

      t.timestamps
    end
  end
end
