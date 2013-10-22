class FinalSale < AnimalSale

  attr_reader :animal

  DISCOUNT = 0.85
  PERCENT_LEFT = 20

  def initialize(animal)
    @animal = animal
  end

  def start!
    return false unless should_start?

    update_packages!
    animal.update_attribute(:final_sale, true)
  end

  def should_start?
    # in this case, percent left is less than 20; otherwise this object wouldn't be created
    !animal.final_sale? 
  end

  def message
    "Final Sale on all cuts until #{animal.name} is sold out!"
  end

end