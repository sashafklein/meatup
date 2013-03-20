require 'spec_helper'

describe "User pages" do

	User.destroy_all
  subject { page }

  	describe "Sign In" do 
		before { visit signin_path }

		it { should have_selector('a', text: 'Sign up now!') }
		it { should have_selector('title', text: full_title('Sign In')) }
	end

	describe "Sign Up" do

	    before { visit signup_path }

	    let(:submit) { "Sign Up" }

	    describe "with invalid information" do
	      it "should not create a user" do
	        expect { click_button submit }.not_to change(User, :count)
	      end

	      describe "after submission" do
	        before { click_button submit }

	        it { should have_content('error') }
	      end
	    end

	    describe "with valid information" do

		      ActionMailer::Base.delivery_method = :test

		      describe "after saving the user" do
		        before do
				      fill_in "Name",         with: "Test Name"
			        fill_in "Email",        with: "test@email.com"
			        fill_in "Password",     with: 'password'
			        fill_in "Confirmation", with: 'password'
			        fill_in "Zip Code", 		with: 94114
			        assert User.count == 0
			        click_button submit
			        assert User.count == 1
			      end

		        it { should have_selector('.alert', text: "MeatUp is still in private Beta.") }
		      end
	    end
	end
end