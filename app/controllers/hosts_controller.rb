class HostsController < ApplicationController
	
  before_filter :signed_in_user
  before_filter :beta_block
  before_filter :host_or_admin, only: [:edit, :new, :update, :destroy, :dashboard]

  def index
  	@hosts = Host.all
  end

   # GET /hosts/1
  def show
  	@host = Host.find(params[:id])
  end

  # GET /hosts/new
  def new
  	@host = Host.new
  end

  # GET /hosts/1/edit
  def edit
  	@host = Host.find(params[:id])
  end

  # POST /hosts
  def create
  	@host = Host.new(params[:host])
    if @host.save
      @host.save
      redirect_to @host, notice: 'Host was successfully created'
    else
      render action: "new"
    end
  end

  # PUT /hosts/1
  def update
    @host = Host.find(params[:id])

    if @host.update_attributes!(params[:host])
        @host.save
        redirect_to @host, notice: "Host was successfully updated."
    else
        render action: "edit"
    end
  end

  # DELETE /hosts/1
  def destroy
    @host = Host.find(params[:id])
    @host.destroy

    redirect_to hosts_url
  end

  def dashboard
    @animal_array = ["Cow", "Pig", "Lamb", "Goat"]
  end

  private

    def host_or_admin
      if signed_in? 
        unless current_user.admin? || current_user.is_host
          redirect_to root_path, notice: "Sign up as host to access."
        end
      else
        redirect_to root_path, notice: "Sign up as host to access."
      end
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

end
