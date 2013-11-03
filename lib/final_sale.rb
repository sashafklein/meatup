class FinalSale < AnimalSale

  attr_reader :animal

  PRICE_MULTIPLE = 0.85

  def initialize(animal)
    @animal = animal
  end

  def message
    "Final Sale on all cuts until #{animal.name} is sold out!"
  end

  def move!
    false
  end

  def move?
    false
  end

  def price_multiple
    PRICE_MULTIPLE
  end

  def type
    'final'
  end


  private

  def transfer!
    update_packages!(price_multiple / AnimalSale::NoSale::PRICE_MULTIPLE)
    animal.update_attribute(:on_opening_sale, false)
  end

end