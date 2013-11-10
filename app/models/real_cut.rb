class RealCut < ActiveRecord::Base
  attr_accessible :animal_id, :cut_id, :flat_price, :weight, :expected_units, :sold_units

  belongs_to :cut
  belongs_to :animal
  has_many :packages
  has_many :lines

  scope :sold_out,  -> { where('expected_units <= sold_units') }
  scope :available, -> { where('expected_units > sold_units') }
  scope :touched,   -> { where('sold_units > ?', 0) }

  delegate :name, :comp, :description,
           to: :cut

  delegate :sale, 
           to: :animal

  delegate :units_left, :units_total, 
           :pounds_left, :pounds_total, :pounds_expected, :pounds_sold,
           :revenue_left, :revenue_total, :revenue_expected, :revenue_sold,
           to: :calculator

  class RealCutError < StandardError; end

  def self.create_from!(a, c)
    raise RealCutError.new("Cut #{c.name} has a 0 package weight") if c.package_weight.zero?
    create!(
      animal_id: a.id,
      cut_id: c.id,
      flat_price: c.price * a.price_multiplier * 100,
      weight: c.package_weight * a.weight_multiplier,
      expected_units: c.percent * a.weight / 100 / c.package_weight
    )
  end

  def discounted?
    sale.active? && cut.incentive?
  end

  def sale_message
    sale.incentive_message
  end

  def list_price
    flat_price * sale_mult
  end

  def savings
    raw_savings > 0 ? raw_savings : 0
  end

  def calculator
    CutCalc.new(self)
  end

  def prep_options
    PrepOption.new(cut, animal).order_list
  end

  def available
    (0..units_left).to_a
  end

  private

  def sale_mult
    sale.price_multiple || 1
  end

  def raw_savings
    1 - (list_price / comp_cents)
  end

  def comp_cents
    100 * comp
  end
end