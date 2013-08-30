class StaticPagesController < ApplicationController
  skip_before_filter :incubate, only: [:incubation, :how]

  def welcome
    redirect_to orders_purchase_path
  end

  def about
  end

  def how
  end

  def contact
  end

  def welcome_email
  end

  def order_email
  	@order = Order.first
  end

  def google
  end

  def incubation
  end
end
