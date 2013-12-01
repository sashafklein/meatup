module Locatable
  
  # delegate :street_address, :phone_number, :zip, :city, :state,
           # :phone, :address,
           # to: :location

  def location
    Location.find_by_id(self.location_id)
  end

  def full_address
    [street_address, city, state].join(", ")
  end

  private

  def location_sufficient
    unless location.sufficient?
      errors[:location] << "Location is incomplete for #{self.inspect}!"
    end
  end
  
end