class AnimalSale
  attr_accessor :animal, :type

  def initialize(animal)
    return false if animal.nil?
    @animal = animal
    @type = determine_sale_type
  end

  def sale
    return false unless type
    send type
  end

  def move_to!(sale_object)
    sale_object.transfer!
  end

  def percent_discounted
    100 * (1 - price_multiple)
  end

  private

  def determine_sale_type
    if animal.conduct_opening_sale? && !animal.on_opening_sale? && animal.percent_left > AnimalSale::OpeningSale::PERCENT_LEFT
      'starter_sale'
    elsif animal.on_opening_sale?
      'opening_sale'
    elsif animal.on_final_sale?
      'final_sale'
    else
      'no_sale'
    end
  end

  def final_sale
    FinalSale.new(animal)
  end

  def opening_sale
    OpeningSale.new(animal)
  end

  def starter_sale
    StarterSale.new(animal)
  end

  def no_sale
    NoSale.new(animal)
  end

  def unsold_package_bundles
    animal.available_cuts.map{ |cut| animal.packages_for(cut).unsold }
  end

  def update_packages!(price_multiple)
    unsold_package_bundles.each do |bundle|
      new_price = bundle.first.price * price_multiple
      new_savings = bundle.first.get_savings_from_benchmark(new_price)
      bundle.update_all!(price: new_price, savings: new_savings)
    end
  end

end