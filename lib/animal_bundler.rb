class AnimalBundler

  attr_reader :animal

  delegate :purchasers, :packages, :lines, :available_cuts, :sold_out_cuts, to: :animal
  
  def initialize(animal)
    @animal = animal
  end

  def available_for_sale
    available_cuts.order('savings DESC').map{ |cut| AnimalCut.new(cut, animal) }
  end

  def sold_out_for_sale
    sold_out_cuts.map{ |cut| AnimalCut.new(cut, animal) }
  end

  def admin_overview
    ItemBundler.new(packages).in_bundles_by_cut
  end

  def sale
    ItemBundler.new(packages).by_cut_sale_and_savings
  end

  # Array of Open Structs with "bundles" of unique (cut/notes) lines
  def sale_email
    ItemBundler.new(lines).in_cut_and_note_bundles
  end

  def labels_by_cut
    ItemBundler.new(packages).sold_in_line_note_bundles
  end

  def log
    labels_by_cut
  end

  def labels_by_user
    purchasers.map{ |u| OpenStruct.new(user: u, packages: u.associated_packages) }
  end
end