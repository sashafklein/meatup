class ChargesController < ApplicationController

  def new
  end

  def create
    # Amount in cents
    @order = Order.find(params[:order_id])
    @amount = (@order.total * 100).to_i

    Stripe::Charge.create(
      :amount      => @amount,
      :card        => params[:stripeToken],
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

    @order.update_attribute(:status, 1)
    @order.user.end_apology
    UserMailer.order_email(@order).deliver unless @order.user.email.include? "@meatup.in"
    @order.animal.check_for_sold if @order.animal.open

    redirect_to @order, notice: "Charge processed successfully!"
    
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
    
  end

end
