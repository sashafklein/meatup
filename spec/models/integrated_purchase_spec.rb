require 'spec_helper'

describe "Integrated Purchase methods" do

  before do 
    @user = FactoryGirl.create(:user)
    @tiny = FactoryGirl.create(:tiny)
    @ground = FactoryGirl.create(:ground)
    @tiny.create_packages
    @order = @tiny.orders.create(user_id: @user.id)
    @order.lines.create(units: 5, cut_id: @ground.id)
  end

  describe 'user.associated_packages(animal)' do
    it "returns all packages the user has purchased from the animal" do
      result = @user.reload.associated_packages(@tiny)
      result.count.should == 5
      result.should == @order.packages
      result.should == Package.where(cut_id: @ground.id)
    end
  end

  describe "purchase methods" do
    
  end

end