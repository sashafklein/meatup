class UserMailer < ActionMailer::Base
  default from: "Meatup <no_reply@meatup.in>"

  def welcome_email(user)
    @user = user
    @url  = "www.meatup.in"
    @meat_url = "www.meatup.in/purchase"
    attachments.inline['meatup_logo_white.png'] = File.read('/users/sashafklein/rails_projects/bloc/meatup2/app/assets/images/meatup_logo_white.png')
    attachments.inline['grassy_knoll_white_sm.png'] = File.read('/users/sashafklein/rails_projects/bloc/meatup2/app/assets/images/grassy_knoll_white_sm.png')
    mail(:to => user.email, :subject => "Welcome to MeatUp!")
  end

  def order_email(order)
  	@user = order.user
  	@order = order
  	@lines = order.lines
  	mail(:to => @user.email, :subject => "Thanks for the Order!")
  end

end
