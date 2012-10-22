module OrdersHelper
	def package_builder(left, line)
		string = "["
		left.each do |p|
			string += "[p,p]"
			if p != left.last
				string += ","
			end
		end
		string += "]"
		line.select :units, string
	end

	def prep_helper(c)
		counter = 0
		if @order_animal.animal_type == "Cow"
			if @b.ground && c.name == "Beef Stew" || c.name == "London Broil" || c.name == "Eye of Round" || c.name == "Cross Rib" || c.name == "Rump Steak" || c.name == "Bottom Round" || c.name == "Chuck Roast" || c.name == "Sirloin Tip" || c.name == "Top Sirloin" || c.name == "Shank" || c.name == "Flap Meat" || c.name == "Neck"
				@prep_array << ["Grind It", "Ground"]
			else
				counter += 1
			end
			if @b.stew && c.name == "London Broil" || c.name == "Eye of Round" || c.name == "Cross Rib" || c.name == "Rump Steak" || c.name == "Bottom Round" || c.name == "Chuck Roast" || c.name == "Shank" || c.name == "Neck"
				@prep_array << ["Turn to Stew", "As Stew"]
			else
				counter += 1
			end
			if @b.boneless && c.name == "Ribeye" || c.name == "Short Ribs"
				@prep_array << ["Debone It", "Deboned"]
			else
				counter += 1
			end

			if counter == 3
				@prep_array = [""]
			end
		end
	end

	# Returns a list of packages, one per cut, ordered by savings, sold-out at bottom
	def make_list(animal)
		shortened = shorten(animal) # Turns all packages into a one-per list
		on_sale = remove_sold_out(shortened, animal) # Removes sold_out items from list
		by_savings = arrange_packages(on_sale) # A one-per, savings-organized list
		sold_bottom = to_bottom(shortened, by_savings, animal) 
		sold_bottom
	end

	# Creates a complete list of packages -- one per cut (sold-out included)
	def shorten(animal)
		package_array = []
		animal.packages.each do |p|
			if package_array.any?
				counter = 0
				package_array.each do |element|
					if p.cut == element.cut
					 	counter += 1
					end
				end
				if counter == 0
					package_array << p
				end
			else 
				package_array << p
			end	
		end
		package_array
	end

	def remove_sold_out(shortened, animal)
		cleaned_up = []
		shortened.each do |p|
			animal_list = Package.where(:animal_id => animal.id)
			full_list = animal_list.where(:cut_id => p.cut.id)
			counter = 0

			full_list.each do |package|
				unless package.sold
					# Counter > 1 means there are unsold packages
					counter += 1
				end
			end

			# A single unsold package means it's not sold out
			if counter > 0
				cleaned_up << p
			end 
		end
		cleaned_up
	end

	def arrange_packages(shortened)
		shortened.each do |p|
			savings = (100 * (p.cut.comp - p.price) / p.cut.comp)
			p.update_attribute(:savings, savings)
		end
		savings_list = shortened.sort_by{ |p| -p[:savings] }
		savings_list
	end

	def to_bottom(shortened, by_savings, animal)

		# Create a bottom layer of sold out packages
		bottom = []

		shortened.each do |p|
			animal_list = Package.where(:animal_id => animal.id)
			full_list = animal_list.where(:cut_id => p.cut.id)
			counter = 0

			full_list.each do |package|
				unless package.sold 
					counter += 1
				end
			end

			# A single unsold package means it's not sold out
			if counter == 0
				p.update_attribute(:savings, -1)
				bottom << p
			end 
		end

		# Combine, with sold-out at bottom 
		complete = []
			by_savings.each do |t|
				complete << t
			end
			bottom.each do |b|
				complete << b
			end

		complete

	end

end
