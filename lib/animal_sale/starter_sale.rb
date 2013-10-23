class AnimalSale::StarterSale

  attr_reader :animal

  PRICE_MULTIPLE = 0.9

  def initialize(animal)
    @animal = animal
  end

  def price_multiple
    PRICE_MULTIPLE
  end

  def type
    'starter'
  end

  def move?
    true  
  end

  def move!
    animal.update_attribute(:on_opening_sale, true)
  end

end