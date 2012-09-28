class LinesController < ApplicationController
	
   # GET /lines
  def index
  	@lines = Line.all
  end

   # GET /lines/1
  def show
  	@line = Line.find(params[:id])
  end

  # GET /lines/new
  def new
  	@line = Line.new
    @line.cuts.build
  end

  # GET /lines/1/edit
  def edit
  	@line = Line.find(params[:id])
  end

  # POST /lines
  def create
  	@line = Line.new(params[:line])

    if @line.save
      redirect_to @line, notice: 'Line was successfully created'
    else
      render action: "new"
    end
  end

  # PUT /lines/1
  def update
    @line = Line.find(params[:id])

    if @line.update_attributes(params[:line])
        redirect_to @line, notice: "Line was successfully updated."
      else
        render action: "edit"
      end
  end

  # DELETE /lines/1
  def destroy
    @line = Line.find(params[:id])
    @line.destroy

    redirect_to lines_url
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
