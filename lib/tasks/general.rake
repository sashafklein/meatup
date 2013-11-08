task create_first_real_cuts: :environment do 
  Animal.find_each do |a|
    a.cuts.where('package_weight != 0').each do |c|
      mult = a.mult || 1
      weight_mult = 1
      packages = a.packages_for(c)

      new_real_cut = RealCut.create!(
        animal_id: a.id,
        cut_id: c.id,
        flat_price: c.price * mult * 100,
        weight: c.package_weight * weight_mult,
        expected_units: c.percent * a.weight / 100 / c.package_weight,
        sold_units: packages.where(sold: true).count
      )
      puts "New Real Cut: c_id \##{new_real_cut.cut_id}, animal #{a.name}"

      if packages.update_all(real_cut_id: new_real_cut.id)
        puts "Packages for #{c.name} updated successfully!"
      end
    end
  end
end

task sold_into_real_cuts: :environment do
  Animal.find_each do |a|
    a.real_cuts.each do |cut|
      sold_packages = cut.packages.where(sold: true)
      puts "Updating #{cut.name} sold_units"
      cut.update_attribute(:sold_units, sold_packages.count)
    end
  end

  if RealCut.where(sold_units: 0).count != RealCut.count
    Package.where(sold: true).destroy_all
  end
end

task recreate_sold_packages: :environment do
  Line.find_each do |l|
    real_cut = l.real_cut
    weight = real_cut.cut.package_weight
    puts "Creating #{real_cut.sold_units} sold packages for #{real_cut.name}"
    l.units.times do 
      l.packages.create!(
        sold: true,
        true_weight: weight,
        real_cut_id: real_cut.id
      )
    end
  end

  puts "All created"

  if Line.first(20).map{ |l| l.packages.count == l.units }.all?
    Package.where(sold: false).destroy_all
    puts "All unsold destroyed"
  end
end