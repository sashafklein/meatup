class AnimalBundler

  attr_reader :animal
  
  def initialize(animal)
    @animal = animal
  end

  def available_for_order_page
    animal.available_cuts.order('savings DESC').map do |cut|

      packages = cut.packages_for_animal(animal).unsold
      representative_package = packages.first
      
      OpenStruct.new(
        name: cut.name,
        cut_id: cut.id,
        description: cut.description,
        savings: representative_package.savings,
        weight: cut.package_weight,
        price: representative_package.price,
        prep_options: cut.order_preparations,
        availability: (0..packages.count).to_a,
        sales: PackageSaleCalculator.new(representative_package)
      )
    end
  end

  def sold_out_for_order_page
    animal.sold_out_cuts.map do |cut|
      OpenStruct.new(
        name: cut.name,
        cut_id: cut.id,
        description: cut.description,
        weight: cut.package_weight,
        price: PackagePricer.new(cut: cut, animal: animal).normal
      )
    end
  end
end