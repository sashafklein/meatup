require 'spec_helper'

describe AnimalCut do

  before(:all) do
    @small = FactoryGirl.create(:butchered_small, mult: 0.9)
    create_some_cuts
    @small.create_packages
    
    order = Order.create(animal_id: @small.id)
    order.lines.create(cut_id: @ground.id, units: 5)
    @small.update_attribute(:final_sale, true)
    order.lines.create(cut_id: @london.id, units: @small.cut_packages(@london).count)
  end

  it "provides accurate information for sold-out cuts" do
    animal_cut = AnimalCut.new(@london, @small)
    animal_cut.price.should == (@london.package_price * 0.9) * 0.85 # 0.9 mult * final_sale discount
    animal_cut.package_weight.should == @london.package_weight / 20 # The cow is 1/20th the average size
    animal_cut.prep_options.should == ["None", "Grind"] # Butcher doesn't cut stew meat
    @london.prep_options.should == "grind stew"
  end

  it "provides accurate information for available cuts" do
    animal_cut = AnimalCut.new(@ground, @small)
    animal_cut.availability.count.should == @small.cut_packages(@ground).count - 5
    animal_cut.prep_options.should == ["None"]
  end
end