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

  def incubation
  end

  def purchase
    @types = AnimalType.instance_list
  end

  def list
    @type = AnimalType.new(params[:id])
  end
end
