class PackagesController < ApplicationController

before_filter :signed_in_user
before_filter :beta_block
before_filter :admin_user

   # GET /packages
  def index
  	@packages = Package.all
  end

   # GET /packages/1
  def show
  	@package = Package.find(params[:id])
  end

  # GET /packages/new
  def new
  	@package = Package.new
  end

  # GET /packages/1/edit
  def edit
  	@package = Package.find(params[:id])
  end

  # POST /packages
  def create
  	@package = Package.new(params[:package])

    if @package.save
      redirect_to @package, notice: 'Package was successfully created'
    else
      render action: "new"
    end
  end

  # PUT /packages/1
  def update
    @package = Package.find(params[:id])

    if @package.update_attributes(params[:package])
        redirect_to @package, notice: "Package was successfully updated."
      else
        render action: "edit"
      end
  end

  # DELETE /packages/1
  def destroy
    @package = Package.find(params[:id])
    @package.destroy

    redirect_to packages_url
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
