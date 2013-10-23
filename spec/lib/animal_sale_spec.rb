require 'spec_helper'

describe AnimalSale do

  before(:each) do
    @tiny = FactoryGirl.create(:tiny, conduct_final_sale: true, conduct_opening_sale: true)
    @tiny.stub(:percent_left).and_return(100)
  end

  it "initializes an OpeningSale when the bool is checked and the animal is fresh" do
    sale = AnimalSale.new(@tiny).sale
    sale.class.should == AnimalSale::OpeningSale
    sale.price_multiple.should == AnimalSale::OpeningSale::PRICE_MULTIPLE
  end

  it "considers the OpeningSale over once enough time has passed" do
    @tiny.stub(:created_at).and_return (AnimalSale::OpeningSale::TIME_INTO.seconds - 100).ago

    AnimalSale.new(@tiny).sale.should_end?.should be_true
  end

  it "considers the OpeningSale over once enough has sold" do
    @tiny.created_at.should > AnimalSale::OpeningSale::TIME_INTO.seconds.ago
    AnimalSale.new(@tiny).sale.class.should == AnimalSale::OpeningSale

    @tiny.stub(:percent_left).and_return 50

    @tiny.percent_left.should < AnimalSale::OpeningSale::PERCENT_LEFT
    
    sale = AnimalSale.new(@tiny).sale
    sale.class.should == AnimalSale::NoSale
    sale.price_multiple.should == AnimalSale::NoSale::PRICE_MULTIPLE
  end

  it "doesn't initialize a FinalSale until both conditions are met" do
    @tiny.stub(:percent_left).and_return 50

    @tiny.conduct_final_sale.should be_true
    AnimalSale.new(@tiny).sale.class.should == AnimalSale::NoSale
    
    @tiny.stub(:percent_left).and_return(18)
    
    sale = AnimalSale.new(@tiny).sale
    sale.class.should == AnimalSale::FinalSale
    sale.price_multiple.should == AnimalSale::FinalSale::PRICE_MULTIPLE
  end

end