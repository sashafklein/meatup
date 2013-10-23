require 'spec_helper'

describe Animal do

  before(:all) do
    create_connected_paul_ryan
    create_some_cuts
  end

  describe "create_packages" do

    it "creates the appropriate number of packages" do
      expect { @paul.create_packages! }.to change{ Package.count }.by(68)
    end

    it "prices the packages appropriately" do
      @paul.create_packages!

      ground_packages = Package.where(cut_id: @ground.id)
      london_packages = Package.where(cut_id: @london.id)

      Package.where(cut_id: @filet.id).size.should == 3
      Package.where(cut_id: @stew.id).size.should == 12
      london_packages.size.should == 3
      ground_packages.size.should == 50

      ground_packages.reject{ |p| p.price == 2 }.size.should == 0
      london_packages.first.price.should == 4
    end
  end

  describe "#wholesale_cost" do
    it "chooses the right cost" do
      @paul.create_packages!

      @paul.wholesale_cost.ceil.to_i.should == 140
    end
  end

  describe '#total_revenue' do
    it "calculates correctly" do
      @paul.create_packages!
      @paul.packages.where(cut_id: @filet.id).update_all(sold: true, true_weight: @filet.package_weight)

      @paul.reload.revenue_made.should == 180

      Package.any_instance.stub(:weighted?).and_return(true)
      @paul.packages.unsold.update_all(sold: true)
      @paul.reload.revenue_made.should == 180
    end
  end

  describe "finer-grain money calcs" do
    describe '#profit' do
      it "subtracts revenue from total cost" do
        @paul.create_packages!
        @paul.profit.floor.to_i.should == -140.0
        @paul.packages.where(cut_id: @filet.id).update_all(sold: true, true_weight: @filet.package_weight)
        @paul.reload.profit.to_i.should == 40
      end
    end
  end

  describe 'AnimalCalc methods' do
    before do
     @tiny = FactoryGirl.create(:tiny)
     create_some_cuts
     @tiny.create_packages!
    end

    describe 'status-dependent methods' do
      before do
        order = @tiny.orders.create(status: 1)
        order.lines.create(units: 2, cut_id: @ground.id)
        order2 = @tiny.orders.create(status: 2)
        order2.lines.create(units: 3, cut_id: @ground.id)
      end

      describe 'downpaid_total' do
        it 'calculates the total of downpaid orders only' do
          expected_total = 2 * @ground.package_weight * @ground.price
          @tiny.downpaid_total.should == expected_total
        end
      end

      describe 'paid_total' do
        it 'calculates the total of paid orders only' do
          expected_total = 3 * @ground.package_weight * @ground.price
        end
      end

      describe 'paid_orders' do
        it 'returns a collection of only the orders with paid status' do
          @tiny.paid_orders.count.should == 1
          @tiny.paid_orders.first.lines.first.units.should == 3
        end
      end

      describe 'revenue_made' do
        it "returns calculates unknown true_weights as 0" do
          @tiny.packages.sold.count.should == 5
          @tiny.revenue_made.should == 10.0
          @tiny.packages.sold.first.update_attribute(:true_weight, nil)
          @tiny.revenue_made.should == 8.0 
        end

        it "returns total revenue if all weights are updated" do
          @tiny.packages.sold.update_all(true_weight: @ground.package_weight)
          @tiny.revenue_made.should == 5 * @ground.package_weight * @ground.price
        end
      end

      describe 'revenue_possible' do
        it 'returns the cut-calculated revenue of the animal' do
          cuts = Cut.where(id: @tiny.packages.pluck(:cut_id).uniq)
          expected_revenue = cuts.map do |cut|
            @tiny.packages_for(cut).count * cut.price * cut.package_weight
          end.sum
        end
      end

      describe 'wholesale_cost' do
        before do
          @tiny.stub(:butcher).and_return(OpenStruct.new({ wrapping_price: 0.5 }))
        end
        xit "returns the expected cost of the animal, based on ranch and butcher details" do
          #ranch_price(:meat) * weight_ratio(:meat, :live) * weight + fixed_price + butcher_final_price
          #live_price = 1.4, weight_ratio = 0.387, weight = 10, fixed = 0, butcher_final = 0
        end
      end

    end
  end

  # HELPER METHODS FOR CLARITY

  # create some cuts is in spec helper

  def create_connected_paul_ryan
    @sasha = FactoryGirl.create(:sasha)
    @host = FactoryGirl.create(:host)
    @miller = FactoryGirl.create(:miller, user: @sasha)
    @sanders = FactoryGirl.create(:butcher)
    @paul = FactoryGirl.create(:paul_ryan, host: @host, ranch: @miller, butcher: @sanders)
  end

end