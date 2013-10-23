module Package::PackageStatusMethods

  ## CLASS METHODS
  module ClassMethods
    def with_order_status(status)
      first.with_order_status(status)
    end

    def incomplete # 0
      with_order_status(:incomplete)
    end

    def downpaid # 1
      with_order_status(:downpaid)
    end

    def paid # 2
      with_order_status(:paid)
    end

    def complete # 3
      with_order_status(:complete)
    end
  end

  def self.included(base)
    base.extend ClassMethods
  end


  ## INSTANCE METHODS

  def with_order_status(status)
    order_ids = animal.orders.send(status).pluck(:id)
    line_item_ids = Line.where(order_id: order_ids).pluck(:id)
    Package.where(line_id: line_item_ids)
  end

  def incomplete # 0
    with_order_status(:incomplete)
  end

  def downpaid # 1
    with_order_status(:downpaid)
  end

  def paid # 2
    with_order_status(:paid)
  end

  def complete # 3
    with_order_status(:complete)
  end

end