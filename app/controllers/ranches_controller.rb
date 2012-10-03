class RanchesController < ApplicationController
  
  before_filter :admin_user
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
      @ranch.to_meat
      @ranch.save
      redirect_to @ranch, notice: 'Ranch was successfully created'
    else
      render action: "new"
    end
  end

  # PUT /ranches/1
  def update
    @ranch = Ranch.find(params[:id])

    if @ranch.update_attributes!(params[:ranch])
        @ranch.to_meat
        @ranch.save
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