describe Animal do

  before(:all) do
    # empty_all
    create_connected_paul_ryan
    create_some_cuts
  end

  describe "create_packages" do

    it "creates the appropriate number of packages" do
      expect { @paul.create_packages }.to change{ Package.count }.by(136)
    end

    it "prices the packages appropriately" do
      @paul.create_packages

      ground_beef = Cut.find_by_name("Ground Beef")
      london_broil = Cut.find_by_name("London Broil")
      ground_packages = Package.where(cut_id: ground_beef.id)
      
      ground_packages.count.should == 93
      ground_packages.reject{ |p| p.price == 2.63 }.count.should == 0
      Package.find_by_cut_id(london_broil.id).price.should == 4.0
    end
  end

  describe "total_cost" do

    it "chooses the right cost" do
      @paul.create_packages
      @paul.total_cost.to_f.round(1).should == 1702.4
    end
  end

  # HELPER METHODS FOR CLARITY
  def create_some_cuts
    %w(ground london cross stew brisket).map(&:to_sym).each do |cut_factory|
      FactoryGirl.create(cut_factory)
    end
  end

  def create_connected_paul_ryan
    @sasha = FactoryGirl.create(:sasha)
    @host = FactoryGirl.create(:host)
    @miller = FactoryGirl.create(:ranch, user: @sasha)
    @sanders = FactoryGirl.create(:butcher)
    @paul = FactoryGirl.create(:paul_ryan, host: @host, ranch: @miller, butcher: @sanders)
  end

  def empty_all
    model_list = %w( User Ranch Butcher Cut Animal Package ).map(&:constantize)
    model_list.each(&:delete_all)
  end
end