class AddColumnTrueWeightToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :true_weight, :float
  end
end
