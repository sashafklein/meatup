class RemoveRanchAnimalColumnsFromRanches < ActiveRecord::Migration
  def change

    Ranch.copy_data_to_ranch_animals
    
    remove_column :ranches, :cow_meat
    remove_column :ranches, :pig_meat
    remove_column :ranches, :lamb_meat
    remove_column :ranches, :goat_meat
    remove_column :ranches, :cow_hanging
    remove_column :ranches, :pig_hanging
    remove_column :ranches, :lamb_hanging
    remove_column :ranches, :goat_hanging
    remove_column :ranches, :cow_live
    remove_column :ranches, :pig_live
    remove_column :ranches, :lamb_live
    remove_column :ranches, :goat_live
    remove_column :ranches, :cow
    remove_column :ranches, :pig
    remove_column :ranches, :lamb
    remove_column :ranches, :goat
    remove_column :ranches, :cow_fixed
    remove_column :ranches, :pig_fixed
    remove_column :ranches, :lamb_fixed
    remove_column :ranches, :goat_fixed

    Animal.find_each{ |a| a.update_attribute(:animal_type, a.animal_type.downcase) }
    Cut.find_each{ |c| c.update_attribute(:animal_type, c.animal_type.downcase) }
  end
end
