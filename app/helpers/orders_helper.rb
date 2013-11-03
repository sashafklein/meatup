module OrdersHelper

	def display_savings(savings)
		if savings > 0.01
			number_to_percentage((savings), :precision => 0)
		elsif savings == -1
			'NA'
		elsif savings == 0
			number_to_percentage(0, :precision => 0)
		end
	end

	def savings_class(savings)
		if savings > -1
			'savings'
		else
			'not_applicable'
		end
	end

	def bool_select
		options_for_select([["No", false], ["Yes", true]])
	end

	def host_select
		selected = current_user if signed_in?
		host_array = Host.all.map{ |host| [host.user.name, host.id] }
		options_for_select(host_array, selected: selected)
	end

	def animal_type_select
		%w( Cow Pig Lamb Goat).map{ |type| [type, type.downcase] }
	end

end
