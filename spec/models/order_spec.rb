describe Order do
  describe "creation" do

    before do 
      create_some_cuts
      @small = FactoryGirl.create(:small)
      @order = Order.new(animal_id: @small.id)
    end

    describe "#save_with_lines!(lines)" do
      it "saves lines with order" do
        lines = new_lines_for_animal(@small)
        @order.lines.should be_empty
        @order.save_with_lines!(lines)
        @order.should be_persisted
        @order.lines.count.should == lines.count
      end
    end
  end

  describe "destruction" do
    
    before do 
      create_some_cuts
      @small = FactoryGirl.create(:small)
      @order = Order.new(animal_id: @small.id)
    end

    describe '#rollback' do
      it "calls line.rollback! for each of its lines, then destroys itself and the lines" do
        @order.save_with_lines!(new_lines_for_animal(@small))
        @order.lines.each{ |l| l.should_receive(:rollback!) }
        expect{ @order.rollback! }.to change{ Order.count }.by(-1)
        Line.count.should == 0
      end
    end
  end

  def new_lines_for_animal(animal)
    @small.real_cuts.map do |rc|
      Line.new(real_cut_id: rc.id, units: 2)
    end
  end
end