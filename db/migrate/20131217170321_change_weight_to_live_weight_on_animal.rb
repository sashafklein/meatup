class ChangeWeightToLiveWeightOnAnimal < ActiveRecord::Migration
  def change
    rename_column :animals, :weight, :live_weight
  end
end
