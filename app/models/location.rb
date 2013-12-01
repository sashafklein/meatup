class Location < ActiveRecord::Base
  attr_accessible :city, :phone_number, :state, :street_address, :zip

  validate :some_attribute_present?

  def address
    street_address
  end

  def phone
    phone_number
  end

  def complete?
    attrs = %w( street_address city phone_number state zip )
    attrs.all?{ |a| send("#{a}_valid?") }
  end

  def sufficient?
    some_attribute_present?
  end

  private

  def street_address_valid?
    street_address.present?
  end

  def city_valid?
    city.present?
  end

  def state_valid?
    state.present?
  end

  def phone_number_valid?
    phone_number.present? && phone_number.length > 9
  end

  def zip_valid?
    zip.present? && zip.length > 4
  end

  def some_attribute_present?
    attributes.any?(&:present?)
  end
end
