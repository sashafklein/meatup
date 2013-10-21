class PackageSaleCalculator

  attr_reader :cut, :animal, :package, :animal_sale

  def initialize(package)
    @package = package
    @cut = package.cut
    @animal_sale = AnimalSaleCalculator.new(package.animal)
    @type = determine_sale_type
  end

  def message
    case type
    when 'incentive' then "EXTRA 10% OFF!"
    when 'final' then "EXTRA 15% OFF!"
    else ""
    end
  end

  def type
    @type
  end

  def any?
    type.present?
  end

  def determine_sale_type
    return 'incentive' if cut.incentive? && animal_sale.opening_sale?
    return 'final' if animal_sale.final_sale?
  end
end