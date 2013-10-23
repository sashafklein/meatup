class AnimalCalc

  attr_reader :animal

  delegate :packages, :orders, :ranch, :butcher, :animal_type, :weight, to: :animal

  def initialize(animal)
    @animal = animal
  end

  def downpaid_total
    packages.downpaid.map(&:expected_revenue).sum
  end

  def downpaid_pounds
    packages.downpaid.map(&:expected_weight).sum
  end

  def paid_total
    packages.paid.map(&:paid_revenue).sum
  end

  def paid_pounds
    packages.paid.map(&:fallback_weight).sum
  end

  def paid_orders
    orders.paid
  end

  def revenue_made
    packages.sold.map(&:real_revenue).sum || 0
  end

  def revenue_possible
    packages.map(&:expected_revenue).sum
  end

  def wholesale_cost
    ranch_price(:meat) * weight_ratio(:meat, :live) * weight + fixed_price + butcher_final_price
  end

  def profit
    revenue_made - wholesale_cost
  end

  def left_to_make
    revenue_possible - revenue_made
  end

  def avg_price
    revenue_possible / pounds_total
  end

  def avg_weight
    pounds_total / packages.count
  end

  def pounds_total
    packages.map(&:expected_weight).sum
  end

  def pounds_sold
    packages.sold.map(&:fallback_weight).sum
  end

  def pounds_left
    packages.unsold.map(&:fallback_weight).sum
  end 

  def percent_left
    (100 * pounds_left) / pounds_total
  end  

  def best_lb_estimate
    packages.map(&:fallback_weight).sum
  end

  def expected_margins 
    revenue_possible - wholesale_cost
  end

  ## External logic accessors

  def ranch_price(weight_type)
    ranch.price_for(animal_type, weight_type)
  end

  def weight_ratio(first, second)
    WeightRatio.new(animal_type).ratio(first, second)
  end

  def fixed_price
    ranch_price(:fixed)
  end

  def butcher_final_price
    butcher.real_final_price
  end
end