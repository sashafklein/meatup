class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def beta_block
  	if !current_user.beta
  		redirect_to root_path, error: "MeatUp is still in private beta. We'll let you know when we're accepting new users!"
  	end
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

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
    if signed_in?
      if current_user.email.include? "@meatup.in"
        redirect_to root_path, notice: "Please enter real email before ordering."
      end
    end
  end

  def incubate
    redirect_to incubation_path
  end

end
