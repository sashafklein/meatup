module AnimalsHelper
	def animal_calculator
		@revenue = 0
		@animal.orders.each do |o|
			o.lines.each do |l|
				l.packages.each do |p|
					@revenue += p.price * p.cut.package_weight
				end
			end	
		end	
		@lbs_sold = 0
		@lbs_meat = 0
		@possible = 0
		@margins = 0
		@animal.packages.each do |p|
			unless p.cut.percent == 0
				@lbs_sold += (p.original - p.left) * p.cut.package_weight
				@lbs_meat += p.original * p.cut.package_weight
				@possible = @lbs_meat * p.price 
			end
		end
		@r = @animal.ranch
    	@b = @animal.butcher

	    if @b.vacuum_price > @b.wrap_price
	      @wrapping = @b.vacuum_price
	    else
	      @wrapping = @b.wrap_price
	    end 

	    if @animal.animal_type == "Cow"
			@margins = @possible - (@lbs_meat * (@r.cow_meat + (@b.hanging_price + @wrapping)))
		elsif @animal.animal_type == "Pig"
			@margins = @possible - (@lbs_meat * (@r.pig_meat + (@b.hanging_price + @wrapping)))
		elsif @animal.animal_type == "Lamb"
			@margins = @possible - (@lbs_meat * (@r.lamb_meat + (@b.hanging_price + @wrapping)))
		elsif @animal.animal_type == "Goat"
			@margins = @possible - (@lbs_meat * (@r.goat_meat + (@b.hanging_price + @wrapping)))
		end
	end	
end
