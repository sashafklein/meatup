require 'spec_helper'

describe "Static Pages" do

	subject { page }

	describe "How This Works" do 

		before { visit how_path }

		it { should have_selector('h1', text: 'How MeatUp Works') }
	    it { should have_selector('title', text: full_title('How It Works')) } 
		it { should have_content('Consumers') }
		it { should have_content('Hosts') }
		it { should have_content('Ranchers') }
		it { should have_content('Butchers') }
		it { should have_content('Frequently Asked Questions') }
		it { should have_content('in touch with us') }
	end

end
