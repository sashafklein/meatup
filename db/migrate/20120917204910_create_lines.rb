class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.integer :units
      t.string :notes
      t.reference :order

      t.timestamps
    end
  end
end
