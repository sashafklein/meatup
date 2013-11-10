class Charge
  attr_reader :order, :amount, :token

  delegate :animal, :user, to: :order

  def initialize(order_id, amount)
    @order = Order.find(order_id)
    @amount = amount
    @token = token
  end

  def charge!
      Stripe::Charge.create!(
        amount:      amount,
        card:        token,
        description: description,
        currency:    'usd'
      )
  end

  def update_order_status!
    order.increment_status!
    user.end_apology
    if order.paid?
      order.update_attribute(:total, amount)
    end
    close_animal_if_done!
  end

  def send_email_notifications!
    if order.downpaid?
      UserMailer.order_email(order).deliver unless user.email.include? "@meatup.in"
      UserMailer.new_order(order).deliver unless user.email.include? "@meatup.in"
    elsif order.paid?
      UserMailer.finalized_order(order).deliver unless user.email.include? "@meatup.in"
    end
  end

  def notice
    if order.downpaid?
      "Charge processed successfully!"
    elsif order.paid?
      "Payment update complete!"
    end
  end

  private

  def close_animal_if_done!
    animal.check_for_sold if animal.open
  end

  def description
    if order.incomplete?
      "Deposit on #{animal.name}"
    elsif order.downpaid?
      "Final cost difference"
    end
  end
end