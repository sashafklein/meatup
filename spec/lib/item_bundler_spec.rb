require 'spec_helper'

describe ItemBundler do

  describe "Package Bundles" do

    describe "methods than only need two cuts to test" do

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

      after(:all) { DatabaseCleaner.clean }

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

    describe "methods that need more cuts" do

      before(:all) do
        @small = FactoryGirl.create(:small)
        create_some_cuts
        @small.create_packages
        order = Order.create(animal_id: @small.id)
        order.lines.create(units: 12, cut_id: @stew.id) # Sell out of stew
        order.lines.create(units: 2, cut_id: @ground.id)
      end

      describe '#in_lines_for_sale' do
        
        before do
          @bundle = ItemBundler.new(@small.packages).in_lines_for_sale
        end

        it "creates a full list of cuts with accurate" do
          @bundle.count.should == @small.cuts.count

          @bundle[3].name.should == "Beef Stew"
          @bundle[3].availability.should == 0
          @bundle[3].savings.should == 32

          ground_packages = Package.where(cut_id: @ground.id)
          @bundle[0].availability.should == ground_packages.count - 2
        end

        it "orders the items by savings (above sold out)" do
          # Ordered by savings, but overridden by sold-out (at bottom)
          @bundle.map{ |cut| cut.name }.should == ["Ground Beef", "London Broil", "Filet Mignon", "Beef Stew"]
        end

        it "includes prep options" do
          @bundle[0].prep_options.should == ["None"] # ground
          @bundle[1].prep_options.should == ["None", "Grind", "Turn to stew"] #london
          @bundle[3].prep_options.should == ["None", "Grind"] # stew
        end
      end

    end
  end
end