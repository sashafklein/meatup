class ItemBundler

  attr_accessor :items

  def initialize(items)
    @items = items
  end
  
  ## PACKAGE BUNDLES

  # Array of Open Structs grouping packages by :sold, :savings, and cut name;
  # Sold Out at bottom, then ordered with savings at top.
  def by_cut_sale_and_savings
    ItemBundler.new(items.unsold).in_savings_bundles + ItemBundler.new(items.sold).in_savings_bundles
  end

  def in_savings_bundles
    bundles = items.group_by { |p| [p.savings, p.cut.name] }.sort
    bundles.map do |bundle|
      OpenStruct.new(
        cut_name: bundle[0][1],
        savings: bundle[0][0],
        packages: bundle[1]
      )
    end
  end

  def sold_in_line_note_bundles
    bundles = items.sold.group_by{ |p| [p.cut.name, p.line.notes] }.sort
    bundles.map do |bundle|
      OpenStruct.new(
        cut_name: bundle[0][0],
        notes: bundle[0][1],
        packages: bundle[1]
      )
    end
  end

  def in_bundles_by_cut
    bundles = items.group_by(&:cut).sort_by{ |group| group.first.name }
    bundles.map do |bundle|
      OpenStruct.new(
        cut: bundle[0],
        sold: bundle[1].select(&:sold).count,
        unsold: bundle[1].reject(&:sold).count,
        price: bundle[1].first.price,
        avg_weight: bundle[1].first.expected_weight,
        total_lb_sold: bundle[1].select(&:sold).count * bundle[1].first.expected_weight
      )
    end
  end

  ## CUT BUNDLES

  def in_lines_for_sale
    unsold_for_sale + sold_for_sale
  end

  def for_sale
    bundles = items.group_by{ |package| package.cut }.sort_by{ |group| group.first.savings }.reverse
    bundles.map do |bundle|
      all_packages = bundle[1]
      unavailable = all_packages.select(&:sold)
      available = all_packages.reject(&:sold)
      package = available.first || unavailable.first
      cut = bundle[0]
      OpenStruct.new(
        name: cut.name,
        cut_id: cut.id,
        description: cut.description,
        savings: package.savings,
        weight: cut.package_weight,
        price: package.price,
        prep_options: cut.order_preparations,
        availability: (0..available.count).to_a,
        sold_out?: available.count == 0,
        sales: package.present? ? PackageSaleCalculator.new(package) : nil
      )
    end
  end

  def unsold_for_sale
    for_sale.select{ |bundle| bundle.availability.count > 0 }
  end

  def sold_for_sale
    for_sale.select{ |bundle| bundle.availability.count == 0 }
  end


  ## LINE BUNDLES

  def in_cut_and_note_bundles
    bundles = items.group_by{ |line| [line.cut.name, line.notes] }.sort
    bundles.map do |line_group|
      OpenStruct.new(
        cut_name: line_group[0][0], 
        notes: line_group[0][1],
        number: line_group[1]
      )
    end
  end

end