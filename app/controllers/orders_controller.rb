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
    @type = AnimalType.new(params[:type])
  end

  def purchase
    @types = AnimalType.instance_list
  end

  # GET /orders/new/:animal_id
  # GET /orders/new/:animal_id.json
  def new
    @order = Order.new
    @order.lines.build
    @animal = Animal.find(params[:animal_id])

    @available = AnimalBundler.new(@animal).available_for_order_page
    @sold_out = AnimalBundler.new(@animal).sold_out_for_order_page

    sale = AnimalSaleCalculator.new(@animal)
    flash[:notice] = sale.message if sale.any?
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
