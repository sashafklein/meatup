class AddColumnPrepOptionsToCuts < ActiveRecord::Migration
  def change
    add_column :cuts, :prep_options, :string, default: nil
  end
end
