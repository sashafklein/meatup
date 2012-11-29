class ChargesController < ApplicationController

  def new
  end

  def create
    # Amount in cents
    @order = Order.find(params[:order_id])
    if @order.status < 1
      @amount = (@order.total * 80).to_i

      Stripe::Charge.create(
        :amount      => @amount,
        :card        => params[:stripeToken],
        :description => "Deposit on #{@order.animal.name}",
        :currency    => 'usd'
      )

      @order.update_attribute(:status, 1)
      @order.user.end_apology
      UserMailer.order_email(@order).deliver unless @order.user.email.include? "@meatup.in"
      @order.animal.check_for_sold if @order.animal.open

      redirect_to @order, notice: "Charge processed successfully!"
    else
      @amount = ((@order.get_difference + 0.2 * @order.total) * 100).to_i

      Stripe::Charge.create(
        :amount      => @amount,
        :card        => params[:stripeToken],
        :description => 'Final Cost Difference',
        :currency    => 'usd'
      )

      @order.update_attribute(:status, 2)
      @order.update_attribute(:total, @order.total + @order.get_difference)
      UserMailer.finalized_order(@order).deliver unless @order.user.email.include? "@meatup.in"

      redirect_to @order, notice: "Payment update complete!"
    end
    
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
    
  end

end
