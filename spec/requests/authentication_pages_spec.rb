require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('a',    text: 'Sign up now!') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with valid information" do
        let(:user) { FactoryGirl.create(:user) }
        before do
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign In"
        end
  
        it { should have_selector('title', text: user.name) }
    end

    describe "with non-beta user" do
      let (:user) { FactoryGirl.create(:user, :beta => false) }
      before do 
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign In"
      end

      it { should have_selector '.alert', text: "MeatUp is still in private Beta." }
    end

    describe "with invalid information" do
      before { click_button "Sign In" }

      it { should have_selector('title', text: full_title('Sign In')) }
      it { should have_selector('.alert', text: 'Invalid') }
    end
  end
end
