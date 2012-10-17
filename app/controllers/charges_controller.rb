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
    UserMailer.order_email(@order).deliver

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
    
  end

end
