class AlterMultColumnsOnAnimal < ActiveRecord::Migration
  def change
    add_column :animals, :price_multiplier, :float, default: 1.0

    Animal.find_each do |animal|
      unless animal.mult.nil?
        animal.update_attribute(:price_multiplier, animal.mult)
      end
    end

    remove_column :animals, :cow_mult
    remove_column :animals, :goat_mult
    remove_column :animals, :lamb_mult
    remove_column :animals, :pig_mult
  end
end
