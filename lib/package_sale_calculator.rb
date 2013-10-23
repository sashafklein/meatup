class PackageSaleCalculator

  attr_reader :cut, :animal, :package, :animal_sale

  def initialize(package)
    @package = package
    @cut = package.cut
    @animal_sale = AnimalSale.new(package.animal).sale
    @type = determine_sale_type
  end

  def message
    if type == 'incentive' || type == 'final'
      "EXTRA #{animal_sale.percent_discounted}% OFF!"
    else
      ""
    end
  end

  def type
    @type
  end

  def any?
    type.present?
  end

  def determine_sale_type
    return 'incentive' if cut.incentive? && animal_sale.type == 'opening_sale'
    return 'final' if animal_sale.type == 'final_sale'
  end
end