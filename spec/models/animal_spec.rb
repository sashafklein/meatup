describe Animal do

  before(:all) do
    create_connected_paul_ryan
    create_some_cuts
  end

  describe "create_packages" do

    it "creates the appropriate number of packages" do
      expect { @paul.create_packages }.to change{ Package.count }.by(68)
    end

    it "prices the packages appropriately" do
      @paul.create_packages

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
      @paul.create_packages

      @paul.wholesale_cost.ceil.to_i.should == 140
    end
  end

  describe '#total_revenue' do
    it "calculates correctly" do
      @paul.create_packages
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
        @paul.create_packages
        @paul.profit.floor.to_i.should == -140.0
        @paul.packages.where(cut_id: @filet.id).update_all(sold: true, true_weight: @filet.package_weight)
        @paul.reload.profit.to_i.should == 40
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