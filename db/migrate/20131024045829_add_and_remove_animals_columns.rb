class AddAndRemoveAnimalsColumns < ActiveRecord::Migration
  def change
    add_column :animals, :conduct_opening_sale, :boolean, default: false
    add_column :animals, :conduct_final_sale, :boolean, default: false
    add_column :animals, :on_opening_sale, :boolean, default: false
    add_column :animals, :on_final_sale, :boolean, default: false

    Animal.find_each do |a| 
      a.update_attribute(:conduct_opening_sale, a.opening_sale)
      a.update_attribute(:conduct_final_sale, a.final_sale)
    end

    remove_column :animals, :opening_sale
    remove_column :animals, :final_sale
  end
end
