describe Line do

  before do 
    create_some_cuts
    @small = FactoryGirl.create(:small)
    @order = Order.create(animal_id: @small.id)
  end

  describe "rollback!" do
    it "destroys the lines and packages and updates the rc" do
      line = @order.lines.create!(
        real_cut_id: @small.real(@ground).id,
        units: 2
      )
      line.packages.count.should == 2
      @small.real(@ground).units_sold.should == 2

      expect{ line.rollback! }.to change{ @small.real(@ground).units_sold }.by(-2)
      Package.count.should == 0
    end
  end
end