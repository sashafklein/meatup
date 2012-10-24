class ButchersController < ApplicationController

  before_filter :butcher_or_admin, only: [:new, :edit, :update, :destroy]

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

    def butcher_or_admin
      if signed_in? 
        unless current_user.admin? || current_user.is_butcher
          redirect_to root_path, notice: "Sign up as butcher to access."
        end
      else
        redirect_to root_path, notice: "Sign up as butcher to access."
      end
    end
end
