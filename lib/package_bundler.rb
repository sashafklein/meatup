class PackageBundler

  attr_accessor :packages

  def initialize(packages)
    @packages = packages
  end
  
  # Array of Open Structs grouping packages by :sold, :savings, and cut name;
  # Sold Out at bottom, then ordered with savings at top.
  def by_cut_sale_and_savings
    packages.unsold.in_savings_bundles + packages.sold.in_savings_bundles
  end

  def in_savings_bundles
    bundles = packages.group_by{ |p| [p.savings, p.cut.name] }.sort
    bundles.map do |bundle|
      OpenStruct.new(
        cut_name: bundle[0][1],
        savings: bundle[0][0],
        packages: bundle[1]
      )
    end
  end

  def sold_in_line_note_bundles
    bundles = packages.sold.group_by{ |p| [p.cut.name, p.line.notes] }.sort
    bundles.map do |bundle|
      OpenStruct.new(
        cut_name: bundle[0][0],
        notes: bundle[0][1],
        packages: bundle[1]
      )
    end
  end

  def in_bundles_by_cut
    bundles = packages.group_by(&:cut).sort_by{ |group| group.first.name }
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
end