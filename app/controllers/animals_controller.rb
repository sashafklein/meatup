class AnimalsController < ApplicationController
   # GET /animals
  def index
  	@animals = Animal.all
  end

   # GET /animals/1
  def show
  	@animal = Animal.find(params[:id])
  end

  # GET /animals/new
  def new
  	@animal = Animal.new
  end

  # GET /animals/1/edit
  def edit
  	@animal = Animal.find(params[:id])
  end

  # POST /animals
  def create
  	@animal = Animal.new(params[:animal])

    if @animal.save
      redirect_to @animal, notice: 'Animal was successfully created'
    else
      render action: "new"
    end
  end

  # PUT /animals/1
  def update
    @animal = Animal.find(params[:id])

    if @animal.update_attributes(params[:animal])
        redirect_to @animal, notice: "Animal was successfully updated."
      else
        render action: "edit"
      end
  end

  # DELETE /animals/1
  def destroy
    @animal = Animal.find(params[:id])
    @animal.destroy

    redirect_to animals_url
  end
end
