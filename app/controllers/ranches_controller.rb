class RanchesController < ApplicationController
  
  before_filter :rancher_or_admin, only: [:new, :update, :destroy, :edit, :index]

  def index
  	@ranches = Ranch.all
  end

   # GET /ranches/1
  def show
  	@ranch = Ranch.find(params[:id])
  end

  # GET /ranches/new
  def new
  	@ranch = Ranch.new
  end

  # GET /ranches/1/edit
  def edit
  	@ranch = Ranch.find(params[:id])
  end

  # POST /ranches
  def create
  	@ranch = Ranch.new(params[:ranch])
    if @ranch.save
      redirect_to @ranch, notice: 'Ranch was successfully created'
    else
      render action: "new"
    end
  end

  # PUT /ranches/1
  def update
    @ranch = Ranch.find(params[:id])

    if @ranch.update_attributes!(params[:ranch])
        redirect_to @ranch, notice: "Ranch was successfully updated."
      else
        render action: "edit"
      end
  end

  # DELETE /ranches/1
  def destroy
    @ranch = Ranch.find(params[:id])
    @ranch.destroy

    redirect_to ranches_url
  end

  private

    def rancher_or_admin
      if signed_in? 
        unless current_user.admin? || current_user.is_rancher
          redirect_to root_path, notice: "Sign in as rancher to access."
        end
      else
        redirect_to root_path, notice: "Sign in as rancher to access."
      end
    end
end
