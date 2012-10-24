require "spec_helper"
require "user"

	describe User do
		it "has a username" do
			User.name.should_not == nil
		end
	end