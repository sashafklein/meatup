# == Schema Information
#
# Table name: animals
#
#  id                   :integer          not null, primary key
#  animal_type          :string(255)
#  name                 :string(255)
#  breed                :string(255)
#  weight               :integer
#  photo                :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  ranch_id             :integer
#  butcher_id           :integer
#  host_id              :integer
#  open                 :boolean          default(TRUE)
#  finalized            :boolean          default(FALSE)
#  hanging_weight       :float
#  meat_weight          :float
#  no_sales             :boolean          default(FALSE)
#  conduct_opening_sale :boolean          default(FALSE)
#  conduct_final_sale   :boolean          default(FALSE)
#  on_opening_sale      :boolean          default(FALSE)
#  on_final_sale        :boolean          default(FALSE)
#  price_multiplier     :float            default(1.0)
#

require 'spec_helper'

describe Animal do

  before(:all) do
    create_some_cuts
    create_connected_small
  end

  describe "real_cut creation" do

    it "builds one real_cut per associated cut" do
      RealCut.count.should == Cut.count - 1
      @small.real_cuts.count.should == AnimalType.new('cow').cuts.count
    end

    it "accurately builds out attributes" do
      real_ground = @small.real_by_name('Ground Beef')
      real_ground.weight.should == 1
      real_ground.flat_price.should == 300 #cents, $2 * 1.5 price multiple
      real_ground.list_price.should == OpeningSale::PRICE_MULTIPLE * real_ground.flat_price
      
      @small.update_attribute(:conduct_opening_sale, false)
      real_ground.reload.list_price.should == real_ground.flat_price
      
      real_ground.expected_units.should == 50
      real_ground.sold_units.should == 0
      real_ground.packages.should == []
    end

    it "does not create packages" do
      @small.packages.count.should == 0
    end
  end

  describe "#wholesale_cost" do
    it "chooses the right cost" do
      @small.wholesale_cost.ceil.to_i.should == 140
    end
  end

  describe '#total_revenue' do
    it "calculates correctly" do
      order = @small.orders.create(user_id: @sasha.id)
      
      real_filet = @small.real_by_name("Filet Mignon")
      real_filet.sold_units.should == 0
      real_filet.packages.should == []

      total_units = real_filet.expected_units
      sale_price = real_filet.list_price

      line = Line.new(real_cut_id: real_filet.id, sale_price: sale_price, units: total_units)
      order.save_with_lines!([line])

      real_filet.reload.sold_units.should == total_units
      real_filet.packages.count.should == total_units

      order.update_attribute(:total, order.make_total)

      @small.reload.revenue_made.should == total_units * sale_price * real_filet.weight
      real_filet.list_price.should == sale_price * (1 / OpeningSale::PRICE_MULTIPLE) # The animal is more than 20% sold
    end
  end

  describe "finer-grain money calcs" do
    describe '#profit' do
      it "subtracts revenue from total cost" do
        @small.profit.floor.to_i.should == -140.0
        real_filet = @small.real(@filet)
        new_line = Line.new(real_cut_id: real_filet.id, units: 1)
        Order.create_from_lines!(@sasha.id, @small.id, [new_line])
        
        @small.reload.profit.to_i.should == -140.0 + (real_filet.weight * real_filet.list_price)
      end
    end
  end

  describe 'AnimalCalc methods' do
    before do
     @small.stub(:butcher).and_return(OpenStruct.new({ real_final_price: 0 }))
    end

    describe 'status-dependent methods' do
      before do
        @real_ground = @small.real(@ground)
        @starting_list = @real_ground.list_price
        order = @small.orders.create(status: 1)
        order.lines.create(units: 2, real_cut_id: @real_ground.id)
        order2 = @small.orders.create(status: 2)
        order2.lines.create(units: 3, real_cut_id: @real_ground.id)
      end

      describe 'downpaid_total' do
        it 'calculates the total of downpaid orders only' do
          expected_total = 2 * @real_ground.list_price * @real_ground.weight
          @small.downpaid_total.should == expected_total
        end
      end

      describe 'paid_total' do
        it 'calculates the total of paid orders only' do
          expected_total = 3 * @real_ground.list_price * @real_ground.weight
          @small.paid_total.should == expected_total
        end
      end

      describe 'paid_orders' do
        it 'returns a collection of only the orders with paid status' do
          @small.paid_orders.count.should == 1
          @small.paid_orders.first.lines.first.units.should == 3
        end
      end

      describe 'revenue_made' do
        xit "returns total revenue if all weights are updated" do
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
          @tiny.stub(:butcher).and_return(OpenStruct.new({ real_final_price: 0 }))
        end
        
        it "returns the expected cost of the animal, based on ranch and butcher details" do
          ranch_live_price = 1.4 # live price per lb
          live_weight = @tiny.weight
          fixed_price = 0
          butcher_final_price = 0

          predicted_value = (ranch_live_price * live_weight) + fixed_price + butcher_final_price
          @tiny.wholesale_cost.should == predicted_value
        end
      end

      describe "pounds_left" do
        it "calculates accurately" do
          @tiny.pounds_left.should == @tiny.packages.map(&:expected_weight).sum - @tiny.packages.sold.map(&:expected_weight).sum
        end

        it "is the opposite of pounds_sold" do
          @tiny.pounds_left.should == @tiny.pounds_total - @tiny.pounds_sold
        end
      end

      describe "expected_margins" do
        it "calculates the difference between cost and sale, given expectations" do
          expected_revenue = @tiny.packages.map{ |p| p.expected_weight * p.price }.sum
          @tiny.expected_margins.should == expected_revenue - @tiny.wholesale_cost
        end
      end

    end
  end

  # HELPER METHODS FOR CLARITY

  # create some cuts is in spec helper

  def create_connected_small
    @sasha = FactoryGirl.create(:sasha)
    @host = FactoryGirl.create(:host)
    @miller = FactoryGirl.create(:miller, user: @sasha)
    @sanders = FactoryGirl.create(:butcher)
    @small = FactoryGirl.create(:small, host: @host, ranch: @miller, butcher: @sanders, price_multiplier: 1.5, conduct_opening_sale: true)
  end

end
