class OrdersController < ApplicationController
  
before_filter :signed_in_user
before_filter :admin_user,     only: [:index, :edit, :update, :destroy]
before_filter :correct_user, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def cow_order
    @order = Order.new
    @order.lines.build
    @meat = "Cow"

    @animal_list = Animal.where(:animal_type => @meat)
    @order_animal = @animal_list.last

    if @order_animal.opening_sale
      
      hours_left = (120 - (Time.now.to_i - @order_animal.created_at.to_i)/60)/60
      mins_left = (120 - (Time.now.to_i - @order_animal.created_at.to_i)/60)%60

      if hours_left == 1 
        time_left = "1 hour and #{mins_left} minutes"
      elsif hours_left > 1
        time_left = "#{hours_left} hours"
      else
        time_left = "#{mins_left} minutes"
      end

      flash[:notice] = "Opening Sale on select cuts for the next #{time_left}!"

    elsif @order_animal.final_sale

      flash[:notice] = "Final Sale on all cuts until #{@order_animal.name} is sold out!"

    end 

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  def pig_order
    @order = Order.new
    @order.lines.build
    @meat = "Pig"

    @animal_list = Animal.where(:animal_type => @meat)
    @order_animal = @animal_list.last

    if @order_animal.opening_sale
      
      hours_left = (120 - (Time.now.to_i - @order_animal.created_at.to_i)/60)/60
      mins_left = (120 - (Time.now.to_i - @order_animal.created_at.to_i)/60)%60

      if hours_left == 1 
        time_left = "1 hour and #{mins_left} minutes"
      elsif hours_left > 1
        time_left = "#{hours_left} hours"
      else
        time_left = "#{mins_left} minutes"
      end

      flash[:notice] = "Opening Sale on select cuts for the next #{time_left}!"

    elsif @order_animal.final_sale

      flash[:notice] = "Final Sale on all cuts until #{@order_animal.name} is sold out!"

    end 

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  def lamb_order
    @order = Order.new
    @order.lines.build
    @meat = "Lamb"

    @animal_list = Animal.where(:animal_type => @meat)
    @order_animal = @animal_list.last

    if @order_animal.opening_sale
      
      hours_left = (120 - (Time.now.to_i - @order_animal.created_at.to_i)/60)/60
      mins_left = (120 - (Time.now.to_i - @order_animal.created_at.to_i)/60)%60

      if hours_left == 1 
        time_left = "1 hour and #{mins_left} minutes"
      elsif hours_left > 1
        time_left = "#{hours_left} hours"
      else
        time_left = "#{mins_left} minutes"
      end

      flash[:notice] = "Opening Sale on select cuts for the next #{time_left}!"

    elsif @order_animal.final_sale

      flash[:notice] = "Final Sale on all cuts until #{@order_animal.name} is sold out!"

    end 

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  def goat_order
    @order = Order.new
    @order.lines.build
    @meat = "Goat"

    @animal_list = Animal.where(:animal_type => @meat)
    @order_animal = @animal_list.last

    if @order_animal.opening_sale
      
      hours_left = (120 - (Time.now.to_i - @order_animal.created_at.to_i)/60)/60
      mins_left = (120 - (Time.now.to_i - @order_animal.created_at.to_i)/60)%60

      if hours_left == 1 
        time_left = "1 hour and #{mins_left} minutes"
      elsif hours_left > 1
        time_left = "#{hours_left} hours"
      else
        time_left = "#{mins_left} minutes"
      end

      flash[:notice] = "Opening Sale on select cuts for the next #{time_left}!"

    elsif @order_animal.final_sale

      flash[:notice] = "Final Sale on all cuts until #{@order_animal.name} is sold out!"

    end 

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])

    respond_to do |format|
      if @order.save
      
        format.html { redirect_to @order}
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
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

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user_id = Order.find(params[:id]).user_id
      @user = User.find_by_id(@user_id)
      unless current_user.admin?
         unless current_user?(@user)
          redirect_to purchase_path, notice: "Specific order-page unavailable to this user."
         end
      end
    end

    # def redirect_user
    #   meat = @order.animal.animal_type.downcase
    #   redirect_to "/orders/#{meat}", notice: "You didn't pay in time. Your order has been rolled back. Please place it again."
    # end
end
