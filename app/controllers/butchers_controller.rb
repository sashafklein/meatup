class ButchersController < ApplicationController

  before_filter :butcher_or_admin, only: [:new, :edit, :update, :destroy, :log]
  before_filter :right_butcher, only: [:log]

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

  def log
    @butcher = Butcher.find(params[:butcher_id])
    @animal = Animal.find(params[:animal_id])
    @packages = @animal.packages_for_log

    if @animal.save
      p.update_attribute(:true_weight, p.actual_lbs + p.actual_oz / 16)
    end

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

    def right_butcher
      @butcher = Butcher.find(params[:butcher_id])
      redirect_to(root_path) unless current_user.butcher == @butcher || current_user.admin?
    end
end
