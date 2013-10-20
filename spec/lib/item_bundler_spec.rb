require 'spec_helper'

describe ItemBundler do

  describe "Package Bundles" do

    before(:all) do
      @tiny = FactoryGirl.create(:tiny)
      create_some_cuts
      @tiny.create_packages
      order = Order.create(animal_id: @tiny.id)
      order.lines.create(units: 1, cut_id: @ground.id, notes: "C")
      order.lines.create(units: 1, cut_id: @ground.id, notes: "A")
      order.lines.create(units: 1, cut_id: @ground.id, notes: "B")
      order.lines.create(units: 1, cut_id: @stew.id, notes: "Stew")
    end

    describe "#by_cut_sale_and_savings" do

      it "layers unsold above sold, but is otherwise alphabetical/savings-sorted" do
        bundle = ItemBundler.new(@tiny.packages).by_cut_sale_and_savings
        
        bundle.count.should == 3

        bundle[0].cut_name.should == "Ground Beef"
        bundle[0].packages.first.should_not be_sold

        bundle[1].cut_name.should == "Beef Stew"
        bundle[1].packages.first.should be_sold

        bundle[2].cut_name.should == "Ground Beef"
        bundle[2].packages.map(&:sold).uniq.should be_true
      end

    end

    describe '#sold_in_line_note_bundles' do
      it "differentiates bundles by cut name and line notes" do
        bundle = ItemBundler.new(@tiny.packages).sold_in_line_note_bundles

        bundle.count.should == 4
        bundle.map(&:cut_name).should == ["Beef Stew", "Ground Beef", "Ground Beef", "Ground Beef"]
        bundle.map(&:notes).should == %w( Stew A B C )
      end
    end

    describe '#in_bundles_by_cut' do
      it "is ordered by cut name and informationally dense" do
        bundle = ItemBundler.new(@tiny.packages).in_bundles_by_cut

        bundle.count.should == 2
        
        bundle.first.cut.name.should == "Beef Stew"
        bundle.first.sold.should == 1
        bundle.first.unsold.should == 0

        bundle.last.cut.name.should == "Ground Beef"
        bundle.last.avg_weight.should == 1.0
        bundle.last.total_lb_sold.should == 3.0
      end
    end
  end
end