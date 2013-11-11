require 'spec_helper'

describe OrdersController do
  describe '#create' do
    it "takes order and nested line attributes and creates an order" do
      params = {
        order: {
          id: 1,
          animal_id: 1,
          lines_attributes: {
            0: { real_cut_id: 1, units: 4, sale_price: 500},
            1: { real_cut_id: 2, units: 0, sale_price: 600},
            2: { real_cut_id: 3, units: 2, sale_price: 200}
          }
        } 
      }

      expect{ post :create, params: params }.to_change{ Order.count }.from(0).to(1)
      
      order = Order.first
      order.lines.count.should == 2
      order.lines.first.packages.count.should == 4
    end
  end
end