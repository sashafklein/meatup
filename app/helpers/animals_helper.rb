module AnimalsHelper
	def unfinalized(bundle)
		count = 0
		bundle.each do |p|
			count += 1 if p.true_weight == nil || p.true_weight == 0
		end
		if count == 0 
			return ")"
		else
			return ", #{count} unfinalized)"
		end
	end
end
