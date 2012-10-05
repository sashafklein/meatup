class UserMailer < ActionMailer::Base
  default from: "Meatup <sasha@meatup.in>"

  def welcome_email(user)
    @user = user
    @url  = "http://meatup.in"
    mail(:to => user.email, :subject => "Welcome to MeatUp!")
  end

  def order_email(order)
  	@user = order.user
  	@order = order
  	@lines = order.lines
  	mail(:to => @user.email, :subject => "Thanks for the Order!")
  end

end
