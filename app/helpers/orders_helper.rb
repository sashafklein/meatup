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
				@prep_array << ["Grind It"]
			else
				counter += 1
			end
			if @b.stew && c.name == "London Broil" || c.name == "Eye of Round" || c.name == "Cross Rib" || c.name == "Rump Steak" || c.name == "Bottom Round" || c.name == "Chuck Roast" || c.name == "Shank" || c.name == "Neck"
				@prep_array << ["Turn to Stew"]
			else
				counter += 1
			end
			if @b.boneless && c.name == "Ribeye" || c.name == "Short Ribs"
				@prep_array << ["Debone It"]
			else
				counter += 1
			end

			if counter == 3
				@prep_array = [""]
			end
		end
	end
end
