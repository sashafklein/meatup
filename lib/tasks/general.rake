task create_first_real_cuts: :environment do 
  Animal.find_each do |a|
    a.cuts.each do |c|
      mult = a.mult || 1
      weight_mult = 1
      packages = a.packages_for(c)

      new_real_cut = RealCut.create!(
        animal_id: a.id,
        cut_id: c.id,
        flat_price: c.price * mult * 100,
        weight: c.package_weight * weight_mult,
        expected_units: c.percent * a.calculate_meat_weight / 100,
        sold_units: packages.where(sold: true).count
      )
      puts "New Real Cut: c_id \##{new_real_cut.cut_id}, animal #{a.name}"

      if packages.update_all(real_cut_id: new_real_cut.id)
        puts "Packages for #{c.name} updated successfully!"
      end
    end
  end
end