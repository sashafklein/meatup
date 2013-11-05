class AnimalSale::NoSale < AnimalSale

  attr_reader :animal

  PRICE_MULTIPLE = 1
  PERCENT_LEFT = 20

  def message
    ''
  end

  def price_multiple
    PRICE_MULTIPLE
  end

  def type
    'none'
  end

  def transfer!
    update_packages!(price_multiple / AnimalSale::OpeningSale::PRICE_MULTIPLE)
    animal.update_attribute(:on_opening_sale, false)
  end

end