class OrdersController < ApplicationController

before_filter :signed_in_user
before_filter :admin_user,     only: [:index, :edit, :update, :destroy]
before_filter :correct_user, only: [:show, :edit, :update, :destroy]

  def index
    @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  def show
    @order = Order.find(params[:id])
    @order.apply_apology_discount! if @order.user.apology

    @timer_params = { 
      data: {
        start: @order.created_at.to_i, 
        now: Time.now.to_i, 
        path: rollback_order_path(@order), 
        redirect: new_animal_order_path(@order.animal, rolled: true)
      }
    }

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  def new
    @order = Order.new
    @order.lines.build
    @animal = Animal.find(params[:animal_id])

    @available = @animal.available_cuts.order('savings DESC').map{ |cut| AnimalCut.new(cut, @animal) }
    @sold_out = @animal.sold_out_cuts.map{ |cut| AnimalCut.new(cut, @animal) }

    sale = AnimalSale.new(@animal).sale
    flash[:notice] = sale.message if sale.message.present?
    flash[:error] = "You ran out of time, and your order has been rolled back." if params[:rolled]
  end


  def create
    # To not save lines without any associated packages
    params[:order][:lines_attributes] = Order.strip_empty_lines(params)
    @order = Order.new(params[:order])

    respond_to do |format|
      if @order.save
        @order.update_attribute(:total, @order.make_total)
      
        format.html { redirect_to @order}
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def rollback
    @order = Order.find params[:id]
    if @order.rollback!
      flash[:error] = "You ran out of time, and your order's been rolled back."
      render json: { success: true }
    else
      render json: { success: false }
    end
  end

   private

    def admin_user
      if signed_in? 
        unless current_user.admin?
          redirect_to root_path, notice: "Sign in as admin to access."
        end
      else
        redirect_to root_path, notice: "Sign in as admin to access."
      end
    end

    def correct_user
      redirect_to(root_path) unless params[:id]
      
      @user = Order.find(params[:id]).user
      unless current_user.admin? || current_user?(@user)
        redirect_to root_path, notice: "Specific order-page unavailable to this user."
      end
    end

end
