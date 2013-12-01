class AnimalBundler

  attr_reader :animal

  delegate :purchasers, :packages, :lines, :available_cuts, :sold_out_cuts, :sold_cuts, to: :animal
  
  def initialize(animal)
    @animal = animal
  end

  def labels_by_cut
    bundle_array = []
    sold_cuts.each do |rc|
      rc.lines.group_by{ |l| l.notes }.each do |line_bundle|
        bundle_array << OpenStruct.new(cut_name: rc.name, notes: line_bundle[0], packages: line_bundle[1].length)
      end
    end
    bundle_array
  end

  def log
    labels_by_cut
  end

  def labels_by_user
    purchasers.map{ |u| OpenStruct.new(user: u, packages: u.associated_packages) }
  end
end