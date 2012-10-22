module HostsHelper

	def ranch_list(animal)
    list = []
    if animal == "Cow"
      Ranch.all.each do |r|
        if r.cow
          list << r 
        end
      end
      ordered = list.sort_by{|r| r[:cow_meat]}
      ordered.first(10)

    elsif animal == "Pig"
      Ranch.all.each do |r|
        if r.pig
          list << r 
        end
      end
      ordered = list.sort_by{|r| r[:pig_meat]}
      ordered.first(10)

    elsif animal == "Lamb"
      Ranch.all.each do |r|
        if r.lamb
          list << r 
        end
      end
      ordered = list.sort_by{|r| r[:lamb_meat]}
      ordered.first(10)

    elsif animal == "Goat"
      Ranch.all.each do |r|
        if r.goat
          list << r 
        end
      end
      ordered = list.sort_by{|r| r[:goat_meat]}
      ordered.first(10)
    end
  end

end
