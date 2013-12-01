class OrdersController < ApplicationController

before_filter :signed_in_user
before_filter :admin_user,     only: [:index, :edit, :update, :destroy]
before_filter :correct_user, only: [:show, :edit, :update, :destroy]

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id]).decorate

    @timer_params = generate_timer_params
  end

  def new
    @order = Order.new
    @order.lines.build
    @animal = Animal.find(params[:animal_id])

    @available = RealCutDecorator.decorate_collection @animal.available_cuts.sort_by(&:savings).reverse
    @sold_out  = RealCutDecorator.decorate_collection @animal.sold_out_cuts
    @sale = AnimalSale.new(@animal).sale
    
    if params[:rolled]
      flash[:error] = "You ran out of time, and your order has been rolled back." 
    elsif @sale.message.present?
      flash[:sale] = @sale.message
    end
  end


  def create
    # To not save lines without any associated packages
    line_attrs = params[:order].delete(:lines_attributes)
    lines = Line.from_attrs(line_attrs)

    @order = Order.new(params[:order])

    respond_to do |format|
      if @order.save_with_lines!(lines)
      
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

    def generate_timer_params
      { 
        start: @order.created_at.to_i, 
        now: Time.now.to_i, 
        path: rollback_order_path(@order), 
        redirect: new_animal_order_path(@order.animal, rolled: true)
      }
    end

end
