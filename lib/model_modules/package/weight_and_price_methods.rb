module Package::WeightAndPriceMethods

  ## CLASS METHODS
  module ClassMethods
    def self.weighed
      where('true_weight IS DISTINCT FROM NULL')
    end
  end

  def self.included(base)
    base.extend ClassMethods
  end


  ## INSTANCE METHODS

  # WEIGHT
    
    def weighed?
      true_weight.present?
    end

    def fallback_weight
      weighed? ? true_weight : expected_weight
    end

    def expected_weight
      cut.package_weight
    end

    def weight_diff
      weighed? ? true_weight - expected_weight : 0
    end

  # REVENUE

    def expected_revenue
      price * expected_weight
    end

    def real_revenue
      weighed? ? price * true_weight : 0
    end

    def fallback_revenue
      weighed? ? real_revenue : expected_revenue
    end

    def revenue_diff
      return 0 unless weighed?
      price * (true_weight - expected_weight)
    end

end