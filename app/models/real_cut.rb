class RealCut < ActiveRecord::Base
  attr_accessible :animal_id, :cut_id, :flat_price, :weight, :expected_units, :sold_units

  belongs_to :cut
  belongs_to :animal
  has_many :packages

  delegate :name, :comp, to: :cut
  delegate :sale, to: :animal

  class RealCutError < StandardError; end

  def self.create_from(a, c)
    raise RealCutError.new("Cut #{c.name} has a 0 package weight") if c.package_weight.zero?
    create!(
      animal_id: a.id,
      cut_id: c.id,
      flat_price: c.price * a.price_multiplier * 100,
      weight: c.package_weight * a.weight_multiplier,
      expected_units: c.percent * a.weight / 100 / c.package_weight
    )
  end

  def list_price
    flat_price * sale_mult
  end

  def savings
    raw_savings > 0 ? raw_savings : 0
  end

  def units_left
    units_expected - units_sold
  end

  def pounds_expected
    weight * units_expected
  end

  def revenue_expected
    weight * flat_price * units_expected
  end

  def pounds_sold
    lines.map(&:pounds).sum
  end

  def revenue_sold
    lines.map(&:revenue).sum
  end

  def pounds_left
    weight * units_left
  end

  def revenue_left
    pounds_left * flat_price
  end

  private

  def sale_mult
    sale.price_multiple || 1
  end

  def raw_savings
    1 - (list_price/comp_cents)
  end

  def comp_cents
    100 * comp
  end

  def lbs
    weight
  end

  def units_sold
    sold_units
  end

  def units_expected
    expected_units
  end

  def units_total
    units_expected
  end

  def lines
    Line.where(real_cut_id: id)
  end

end