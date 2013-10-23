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

end