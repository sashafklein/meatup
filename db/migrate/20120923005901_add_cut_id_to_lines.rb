class AddCutIdToLines < ActiveRecord::Migration
  def change
    add_column :lines, :cut_id, :integer
  end
end
