class AnimalSale
  attr_accessor :animal

  def initialize(animal)
    return false if animal.nil?
    @animal = animal
  end

  def type
    @type ||= determine_sale_type
  end

  def sale
    return false unless type
    send type
  end

  def percent_discounted
    (100 - (100 * price_multiple)).to_i
  end

  def incentive_message
    "#{incentive_type}: EXTRA #{percent_discounted}% OFF!"
  end

  def incentive_type
    type.split("_").map(&:upcase).join(" ")
  end

  def opening?
    type == 'opening_sale'
  end

  def active?
    type != 'none'
  end

  private

  def determine_sale_type
    if animal.conduct_opening_sale? && animal.percent_left > AnimalSale::OpeningSale::PERCENT_LEFT
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

  def no_sale
    NoSale.new(animal)
  end

  # def unsold_package_bundles
  #   animal.available_cuts.map{ |cut| animal.packages_for(cut).unsold }
  # end

  # def update_packages!(price_multiple)
  #   unsold_package_bundles.each do |bundle|
  #     new_price = bundle.first.price * price_multiple
  #     new_savings = bundle.first.get_savings_from_benchmark(new_price)
  #     bundle.update_all(price: new_price, savings: new_savings)
  #   end
  # end

end