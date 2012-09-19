class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.integer :cow_id
      t.integer :cut_id
      t.integer :number

      t.timestamps
    end
  end
end
