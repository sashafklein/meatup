class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :zip, default: nil
      t.string :street_address, default: nil
      t.string :phone_number, default: nil
      t.string :state, default: nil
      t.string :city, default: nil

      t.timestamps
    end

    add_column :ranches, :location_id, :integer, default: nil
    add_index  :ranches, :location_id
    add_column :hosts, :location_id, :integer, default: nil
    add_index  :hosts, :location_id
    add_column :butchers, :location_id, :integer, default: nil
    add_index  :butchers, :location_id

    [Ranch, Butcher, Host].each do |klass|
      klass.find_each do |object|
        
        location = Location.new(
          street_address: object.address,
          state: object.state,
          city: object.city,
          phone_number: object.phone,
          zip: object.zip
        )

        location.save!
        object.update_attribute(:location_id, location.id)
      end
    end
  end
end
