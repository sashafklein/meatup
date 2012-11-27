require 'spec_helper'

describe "User pages" do

  subject { page }

    # describe "Profile Page" do
    #   let(:user) { FactoryGirl.create(:user) }
    #   before { visit user_path(user) }

    #   it { should have_selector('td',    text: user.name) }
    #   it { should have_selector('title', text: full_title(user.name)) }
    # end

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

	        it { should have_selector('title', text: full_title('Sign Up')) }
	        it { should have_content('error') }
	      end
	    end

	    describe "with valid information" do
	      before do
	        fill_in "Name",         with: "Example User"
	        fill_in "Email",        with: "user@example.com"
	        fill_in "Password",     with: "foobar"
	        fill_in "Confirmation", with: "foobar"
	        fill_in "Zip Code", 	with: "94114"
	      end

	      ActionMailer::Base.delivery_method = :test

	      describe "after saving the user" do
	        before { click_button submit }
	        let(:user) { User.find_by_email('user@example.com') }

	        it { should have_selector('title', text: user.name) }
	        it { should have_selector('div.alert.alert-success', text: 'Welcome to MeatUp!') }
	      end

	      it "should create a user" do
	        expect { click_button submit }.to change(User, :count).by(1)
	      end
	    end
	end
end