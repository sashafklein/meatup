class ButchersController < ApplicationController

  before_filter :admin_user
  def index
  	@butchers = Butcher.all
  end

   # GET /butchers/1
  def show
  	@butcher = Butcher.find(params[:id])
  end

  # GET /butchers/new
  def new
  	@butcher = Butcher.new
  end

  # GET /butchers/1/edit
  def edit
  	@butcher = Butcher.find(params[:id])
  end

  # POST /butchers
  def create
  	@butcher = Butcher.new(params[:butcher])

    if @butcher.save
      redirect_to @butcher, notice: 'Butcher was successfully created'
    else
      render action: "new"
    end
  end

  # PUT /butchers/1
  def update
    @butcher = Butcher.find(params[:id])

    if @butcher.update_attributes(params[:butcher])
        redirect_to @butcher, notice: "Butcher was successfully updated."
      else
        render action: "edit"
      end
  end

  # DELETE /butchers/1
  def destroy
    @butcher = Butcher.find(params[:id])
    @butcher.destroy

    redirect_to butchers_url
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
end
