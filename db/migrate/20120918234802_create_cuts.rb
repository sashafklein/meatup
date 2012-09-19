class CreateCuts < ActiveRecord::Migration
  def change
    create_table :cuts do |t|
      t.string :name
      t.float :price
      t.float :percent
      t.float :package
      t.references :line

      t.timestamps
    end
    add_index :cuts, :line_id
  end
end
