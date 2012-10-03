module AnimalsHelper

	def animal_calculator

		@revenue = 0
		@animal.orders.each do |o|
			o.lines.each do |l|
				p_list = l.packages.where(:sold => true)
				p_list.each do |p|
					@revenue += l.cut.package_weight * p.price
				end
			end
		end

		@lbs_sold = 0
		@animal.orders.each do |o|
			o.lines.each do |l|
				if l.packages
					p_list = l.packages.where(:sold => false)
					p_list.each do |p|
						@lbs_sold += l.cut.package_weight
					end
				end
			end
		end

		if @animal.animal_type == "Cow"
			@lbs_meat = @animal.weight * CMOL
		elsif @animal.animal_type == "Pig"
			@lbs_meat = @animal.weight * PMOL
		elsif @animal.animal_type == "Lamb"
			@lbs_meat = @animal.weight * LMOL
		elsif @animal.animal_type == "Goat"
			@lbs_meat = @animal.weight * GMOL
		end

		@possible = 0
		p_list = Package.where(:animal_id => @animal.id)
		p_list.each do |p|
			@possible += p.price * p.cut.package_weight
		end	

		@r = @animal.ranch
    	@b = @animal.butcher

	    if @b.vacuum_price > @b.wrap_price
	      @wrapping = @b.vacuum_price
	    else
	      @wrapping = @b.wrap_price
	    end 

	    @total_cost = 0
	    if @animal.animal_type == "Cow"
			@total_cost = @r.cow_meat + (@b.hanging_price + @wrapping) / CMOH
		elsif @animal.animal_type == "Pig"
			@total_cost = @r.pig_meat + (@b.hanging_price + @wrapping) / PMOH
		elsif @animal.animal_type == "Lamb"
			@total_cost = @r.lamb_meat + (@b.hanging_price + @wrapping) / LMOH
		elsif @animal.animal_type == "Goat"
			@total_cost = @r.goat_meat + (@b.hanging_price + @wrapping) / GMOH
		end
		
		@margins = @possible - @total_cost
	end
end
