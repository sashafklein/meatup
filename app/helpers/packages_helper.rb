module PackagesHelper

	def show_helper
		@a = @order.animal
		@cut_packages = @a.packages.where(:cut_id => @c.id)
		@sold = @cut_packages.where(:sold => true).length
  		@unsold = @cut_packages.where(:sold => false).length
  		@example = @cut_packages.first
  	end
end
