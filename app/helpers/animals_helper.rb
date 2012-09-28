module AnimalsHelper
	def animal_calculator
		@revenue = 0
		@lbs_sold = 0
		@lbs_meat = 0
		@possible = 0
		@animal.packages.each do |p|
				@lbs_sold += (p.original - p.left) * p.cut.package_weight
				@revenue += @lbs_sold * p.cut.price
				@lbs_meat += p.original * p.cut.package_weight
				@possible += @lbs_meat * p.cut.price 
		end
	end	
end
