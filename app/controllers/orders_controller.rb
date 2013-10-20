class OrdersController < ApplicationController

before_filter :signed_in_user
before_filter :beta_block
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
    @order.apply_apology_discount! if @order.user.apology

    @timer = OpenStruct.new( 
      start: @order.created_at.to_i,
      now: Time.now.to_i,
      url: "new/#{@order.animal.id}"
    )

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  def list
    @animal_type = params[:type].capitalize
    @open = Animal.where(:open => true)
    @animals = @open.where(:animal_type => @animal_type)
  end

  def purchase
    @open = Animal.where(:open => true)
    @cows = @open.where(:animal_type => "Cow")
    @pigs = @open.where(:animal_type => "Pig")
    @lambs = @open.where(:animal_type => "Lamb")
    @goats = @open.where(:animal_type => "Goat")
  end

  # GET /orders/new/:animal_id
  # GET /orders/new/:animal_id.json
  def new
    @order = Order.new
    @order.lines.build
    @order_animal = Animal.find(params[:animal])
    @meat = @order_animal.animal_type

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
        @order.update_attribute(:total, @order.make_total)
      
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

    def correct_user
      @user_id = Order.find(params[:id]).user_id
      @user = User.find_by_id(@user_id)
      unless current_user.admin?
         unless current_user?(@user)
          redirect_to orders_purchase_path, notice: "Specific order-page unavailable to this user."
         end
      end
    end

end
