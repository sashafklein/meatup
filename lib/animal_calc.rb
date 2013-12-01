class AnimalCalc

  attr_reader :animal

  delegate :packages, :real_cuts, :orders, :cuts, :ranch, 
           :butcher, :animal_type, :weight, 
           to: :animal

  def initialize(animal)
    @animal = animal
  end

  def downpaid_total
    packages.downpaid.sum(&:expected_revenue)
  end

  def downpaid_pounds
    packages.downpaid.sum(&:expected_weight)
  end

  def paid_total
    packages.paid.sum(&:fallback_revenue)
  end

  def paid_pounds
    packages.paid.sum(&:fallback_weight)
  end

  def paid_orders
    orders.paid
  end

  def revenue_made
    orders.sum(:total)
  end

  def revenue_possible
    real_cuts.sum(:revenue_expected)
  end

  def profit
    revenue_made - wholesale_cost
  end

  def pounds_sold
    packages.sum(&:fallback_weight)
  end

  def pounds_left
    real_cuts.sum{ |rc| rc.units_left * rc.weight }
  end 

  def percent_left
    (100 * pounds_left) / pounds_total
  end  

  def best_lb_estimate
    packages.sum(&:fallback_weight)
  end

  def expected_margins 
    revenue_possible - wholesale_cost
  end

  def meat_weight
    weight * weight_ratio(:meat, :live)
  end

  def weight_ratio(first, second)
    WeightRatio.new(animal_type).ratio(first, second)
  end

  private

  def fixed_price
    ranch_price(:fixed)
  end

  def wholesale_cost
    ranch_price(:live) * weight + fixed_price + butcher_final_price
  end

  def pounds_total
    meat_weight
  end

  def ranch_price(weight_type)
    ranch.price_for(animal_type, weight_type)
  end

  def butcher_final_price
    butcher.real_final_price
  end
end