class AddColumnSalePriceToLines < ActiveRecord::Migration
  def change
    add_column :lines, :sale_price, :integer

    Line.select{ |l| l.packages.count > 0 }.each do |line|
      line.update_attribute(:sale_price, line.real_cut.flat_price)
    end
  end
end
