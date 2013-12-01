# Really, Real Cut Calc
class CutCalc < ActiveRecord::Base

  delegate  :weight, :lines, :sold_units, :expected_units,
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

  def revenue_expected
    pounds_expected * weight
  end

  def pounds_sold
    weighed_pounds + unweighed_pounds
  end

  private

  def weighed_pounds
    lines.weighed.sum(:weighed_pounds)
  end

  def unweighed_pounds
    lines.unweighed.sum(:unweighed_pounds)
  end

  def units_expected
    expected_units
  end

  def pounds_expected
    units_expected * weight
  end
end