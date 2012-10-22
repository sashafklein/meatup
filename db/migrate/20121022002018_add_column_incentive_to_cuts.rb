class AddColumnIncentiveToCuts < ActiveRecord::Migration
  def change
    add_column :cuts, :incentive, :boolean, default: false
  end
end
