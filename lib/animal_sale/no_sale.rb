class AnimalSale::NoSale

  attr_reader :animal

  PRICE_MULTIPLE = 1
  PERCENT_LEFT = 20

  def initialize(animal)
    @animal = animal
  end

  def price_multiple
    PRICE_MULTIPLE
  end

  def move!
    move_to! AnimalSale::FinalSale.new( animal )
  end

  def move?
    animal.conduct_final_sale? && !animal.on_final_sale? && animal.percent_left < PERCENT_LEFT
  end

  def message
    ''
  end

  def type
    'none'
  end

  private

  def transfer!
    update_packages!(price_multiple / AnimalSale::OpeningSale::PRICE_MULTIPLE)
    animal.update_attribute(:on_opening_sale, false)
  end

end