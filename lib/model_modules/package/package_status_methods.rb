module Package::PackageStatusMethods

  ## CLASS METHODS
  module ClassMethods
    def self.with_order_status(status_symbol)
      order_ids = animal.orders.send(status_symbol).pluck(:id)
      line_item_ids = Line.where(order_id: line_item_ids).pluck(:id)
      where(line_item: line_item_ids)
    end
  end

  def self.included(base)
    base.extend ClassMethods
  end


  ## INSTANCE METHODS

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