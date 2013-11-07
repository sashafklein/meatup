class AnimalCut

  attr_reader :cut, :animal

  delegate :id, :description, :name, :percent, :package_weight, to: :cut
  delegate :weight, :animal_type, to: :animal

  class AnimalCutError < StandardError; end
  
  def initialize(cut, animal)
    @cut = cut
    @animal = animal
  end

  def packages
    Package.where(:animal_id => animal.id).where(:cut_id => cut.id)
  end

  def sold_out?
    sold_out.include? cut
  end

  def starting_price
    starting = cut.incentive? ? flat_price * sale_multiple : cut.price
  end

  def list_price
    flat_price * incentive_multiplier
  end

  def sold_out_price
    flat_price
  end

  def savings
    (1 - (list_price / cut.retail_price_benchmark)) * 100
  end

  def prep_options
    cut.order_preparations(animal)
  end

  def packages
    cut.packages_for_animal(animal).unsold
  end

  ## Cut-Free Methods

  def all
    AnimalType.new(animal.animal_type).cuts
  end
  
  def sold_out
    Cut.where(id: sold_out_cut_ids)
  end

  def available
    Cut.where(id: remaining_cut_ids)
  end

  def availability
    (0..packages.count).to_a
  end

  def number_of_packages
    (weight * (percent / 100) / package_weight).to_i
  end

  def expected_weight
    number_of_packages * package_weight
  end

  def expected_revenue
    expected_weight * flat_price
  end

  def discounted?
    sale.active? && cut.incentive?
  end

  def sale_message
    "EXTRA #{sale.percent_discounted}% OFF!"
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
    raise AnimalCutError.new("Nil sale multiple! Animal: #{animal}, cut: #{cut}") if sale.price_multiple.nil?
    sale.price_multiple
  end

  def incentive_multiplier
    cut.incentive? && sale.opening? ? sale_multiple : 1
  end

  def sale
    AnimalSale.new(animal).sale
  end

  def flat_price
    animal.mult * cut.price
  end

end