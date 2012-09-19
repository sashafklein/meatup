class PackagesController < ApplicationController
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
  end

  # PUT /packages/1
  def update
    @package = Package.find(params[:id])
  end

  # DELETE /packages/1
  def destroy
    @package = Package.find(params[:id])
    @package.destroy
  end
end
