class AnimalSale::FinalSale < AnimalSale

  attr_reader :animal

  PRICE_MULTIPLE = 0.85

  def message
    "Final Sale on all cuts until #{animal.name} is sold out!"
  end

  def price_multiple
    PRICE_MULTIPLE
  end

  def type
    'final'
  end

end