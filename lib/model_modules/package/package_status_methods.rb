module Package::PackageStatusMethods

  ## CLASS METHODS
  module ClassMethods
    def with_order_status(status)
      first.with_order_status(status, first.animal)
    end
  end

  def self.included(base)
    base.extend ClassMethods
  end


  ## INSTANCE METHODS

  def with_order_status(status, animal)
    order_ids = animal.orders.send(status).pluck(:id)
    line_item_ids = Line.where(order_id: line_item_ids).pluck(:id)
    Package.where(line_id: line_item_ids)
  end

  def incomplete
    with_order_status(:incomplete)
  end

  def downpaid
    with_order_status(:downpaid)
  end

  def paid
    with_order_status(:paid)
  end

  def complete
    with_order_status(:complete)
  end
end