class CowsController < ApplicationController
   # GET /cows
  def index
  	@cows = Cow.all
  end

   # GET /cows/1
  def show
  	@cow = Cow.find(params[:id])
  end

  # GET /cows/new
  def new
  	@cow = Cow.new
  end

  # GET /cows/1/edit
  def edit
  	@cow = Cow.find(params[:id])
  end

  # POST /cows
  def create
  	@cow = Cow.new(params[:cow])
  end

  # PUT /cows/1
  def update
    @cow = Cow.find(params[:id])
  end

  # DELETE /cows/1
  def destroy
    @cow = Cow.find(params[:id])
    @cow.destroy
  end
end
