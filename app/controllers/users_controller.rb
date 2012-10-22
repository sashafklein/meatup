class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user,   only: [:edit, :show, :update]
  before_filter :admin_user,     only: [:index, :destroy]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      UserMailer.delay.welcome_email(@user) unless @user.email.include? "@meatup.in"
      sign_in @user
      flash[:success] = "Welcome to MeatUp!"
      redirect_to @user
    else
      render 'new'
    end
  end
 
  def index
    @users = User.paginate(page: params[:page])
  end

  def edit
  end

  def update
    if current_user.admin?
      if @user.update_attributes(params[:user], :as => :administrator)
        flash[:success] = "Profile updated"
        sign_in @user
        redirect_to @user
      else
        render 'edit'
      end
    elsif current_user?(@user)
      if @user.update_attributes(params[:user])
        flash[:success] = "Profile updated"
        sign_in @user
        redirect_to @user
      else 
        render 'edit'
      end
    else
        render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user) || current_user.admin?
    end

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
