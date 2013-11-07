class CreateRealCuts < ActiveRecord::Migration
  def up
    create_table :real_cuts do |t|
      t.integer :animal_id
      t.integer :cut_id
      t.integer :flat_price
      t.float   :weight
      t.integer :expected_units
      t.integer :sold_units

      t.timestamps
    end

    add_index   :real_cuts, :animal_id
    add_index   :real_cuts, :cut_id

    add_column  :packages, :real_cut_id, :integer
    add_index   :packages, :real_cut_id
  end

  def down
    drop_table :real_cuts
    remove_column :packages, :real_cut_id
    remove_index :packages, :real_cut_id
  end
end
