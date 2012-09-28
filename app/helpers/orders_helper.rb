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
end
