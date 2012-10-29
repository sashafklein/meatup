class StaticPagesController < ApplicationController
  def welcome
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
end
