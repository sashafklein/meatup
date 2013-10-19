class AddDefaultToNotes < ActiveRecord::Migration
  def change
    change_column :lines, :notes, :string, default: ''
  end
end
