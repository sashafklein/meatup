# Really, Real Cut Calc
class CutCalc < ActiveRecord::Base

  delegate  :flat_price, :weight, :lines, :sold_units, :expected_units,
            to: :cut

  attr_reader :cut

  class CutCalcError < StandardError; end

  def initialize(real_cut)
    @cut = real_cut
  end

  def units_left
    units_expected - units_sold
  end

  def units_total
    units_expected
  end

  def units_sold
    sold_units
  end

  def pounds_left
    units_left * weight
  end

  def pounds_total
    pounds_sold + pounds_left
  end

  def pounds_expected
    units_expected * weight
  end

  def pounds_sold
    weighed_pounds + unweighed_pounds
  end

  def revenue_left
    pounds_left * flat_price
  end

  def revenue_total
    revenue_sold + revenue_left
  end

  def revenue_expected
    pounds_expected * weight
  end

  def revenue_sold
    unweighed_revenue + weighed_revenue
  end

  private

  def weighed_pounds
    lines.weighed.sum(:weighed_pounds)
  end

  def unweighed_pounds
    lines.unweighed.sum(:unweighed_pounds)
  end

  def weighed_revenue
    lines.weighed.sum(:weighed_revenue)
  end

  def unweighed_revenue
    lines.unweighed.sum(:unweighed_revenue)
  end

  def units_expected
    expected_units
  end
end