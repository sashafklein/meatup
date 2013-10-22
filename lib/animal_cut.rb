class AnimalCut

  attr_reader :cut, :animal

  delegate :id, :description, :name, :package_weight, to: :cut

  def initialize(cut, animal)
    @cut = cut
    @animal = animal
  end

  def sold_out_price
    PackagePricer.new(cut: cut, animal: animal).normal
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

end