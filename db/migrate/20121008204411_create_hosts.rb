class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.string :address
      t.string :city
      t.string :state
      t.string :phone

      t.timestamps
    end
  end
end
