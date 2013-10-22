class AnimalSale
  attr_accessor :animal, :type, :sale

  def initialize(animal)
    return false if animal.nil?
    @animal = animal
    @type = determine_sale_type
  end

  def determine_sale_type
    if animal.opening_sale?
      'opening_sale'
    elsif animal.final_sale? || animal.percent_left < 20
      'final_sale'
    else
      nil
    end
  end

  def sale
    return false unless type
    send type
  end

  def final_sale
    FinalSale.new(animal)
  end

  def opening_sale
    OpeningSale.new(animal)
  end

  def unsold_package_bundles
    animal.available_cuts.map{ |cut| animal.cut_packages(cut).unsold }
  end

  def update_packages!
    unsold_package_bundles.each do |bundle|
      new_price = bundle.first.price / DISCOUNT
      new_savings = bundle.first.get_savings_from_benchmark(new_price)
      bundle.update_all!(price: new_price, savings: new_savings)
    end
  end

end