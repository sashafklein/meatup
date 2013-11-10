class ChargesController < ApplicationController

  before_filter :signed_in_user
  before_filter :beta_block

  def new
  end

  def create
    stripe_charge = Charge.new(params[:order_id], params[:amount], params[:stripe_token])

    if stripe_charge.charge!
      if stripe_charge.update_order_status!
        stripe_charge.send_email_notifications!
      end
    end

    redirect_to stripe_charge.order, notice: stripe_charge.notice
    
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end

end
