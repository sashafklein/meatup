class AnimalCut

  attr_reader :cut, :animal

  delegate :id, :description, :name, :percent, :package_weight, to: :cut
  delegate :weight, :animal_type, to: :animal

  class AnimalCutError < StandardError; end
  
  def initialize(cut=nil, animal)
    @cut = cut
    @animal = animal
  end

  ## Cut-Free Methods

  def all
    AnimalType.new(animal.animal_type).cuts.weighted
  end
  
  def sold_out
    Cut.where(id: sold_out_cut_ids)
  end

  def available
    Cut.where(id: remaining_cut_ids)
  end

  ## 

  def packages
    Package.where(:animal_id => animal.id).where(:cut_id => cut.id)
  end

  def sold_out?
    sold_out.include? cut
  end

  def starting_price
    starting = cut.incentive? ? flat_price * sale_multiple : cut.price
  end
  
  def normal_price
    animal.mult * cut.price
  end

  def sold_out_price
    normal_price
  end

  def available_price
    representative_package.price
  end

  def sales
    PackageSaleCalculator.new representative_package
  end

  def representative_package
    packages.unsold.first
  end

  def generate_savings(package_price = nil)
    package_price ||= starting_price
    (1 - (package_price / cut.retail_price_benchmark)) * 100
  end

  def savings
    representative_package.savings
  end

  def prep_options
    cut.order_preparations(animal)
  end

  def packages
    cut.packages_for_animal(animal).unsold
  end

  def availability
    (0..packages.count).to_a
  end

  def number_of_packages
    (weight * (percent / 100) / package_weight).to_i
  end

  private

  # The below don't require a cut
  def sold_out_cut_ids
    sold_cut_ids - remaining_cut_ids
  end

  def sold_cut_ids
    animal.packages.sold.pluck(:cut_id).uniq
  end

  def remaining_cut_ids
    animal.packages.unsold.pluck(:cut_id).uniq
  end

  def sale_multiple
    sale_mult = AnimalSale.new(animal).sale.price_multiple
    raise AnimalCutError.new("Nil sale multiple! Animal: #{animal}, cut: #{cut}") if sale_mult.nil?
    sale_mult
  end

  def flat_price
    animal.mult * cut.price
  end

end