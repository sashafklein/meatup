require 'spec_helper'

describe "Ordering" do

  before do
    create_some_cuts
    @small = FactoryGirl.create(:small)
    @user = FactoryGirl.create(:sasha)
  end

  describe "start to end" do
    
    it "allows you to log in, order, and review your order", :js do
      visit root_path
      click_link 'Sign In'

      within 'table.signinup_table' do
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        click_button 'Sign In'
      end

      visit root_path

      within '.animal-buttons' do
        click_link 'cow'
      end

      save_and_open_page
      within 'table' do
        click_link @small.name
      end

      page.should have_content "Place your order on #{@small.name}"
    end

  end

  def p
    save_and_open_page
  end

end