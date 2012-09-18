class LinesController < ApplicationController
	def create
		@lines = Lines.new(params[:lines])
        if @lines.save!
            redirect_to root_path
        end
	end
end
