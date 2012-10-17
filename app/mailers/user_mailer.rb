class UserMailer < ActionMailer::Base
  default from: "Meatup <no_reply@meatup.in>"

  def welcome_email(user)
    @user = user
    @url  = "www.meatup.in"
    @meat_url = "www.meatup.in/purchase"
    attachments.inline['meatup_logo_white.png'] = File.read("#{Rails.root}/app/assets/images/meatup_logo_white.png")
    attachments.inline['grassy_knoll_white_sm.png'] = File.read("#{Rails.root}/app/assets/images/grassy_knoll_white_sm.png")
    mail(:to => user.email, :subject => "Welcome to MeatUp!")
  end

  def order_email(order)
  	@user = order.user
  	@order = order
    @host = order.animal.host
    @animal = order.animal

      @meat_type = "beef" if order.animal.animal_type == "Cow"
      @meat_type = "pork" if order.animal.animal_type == "Pig"
      @meat_type = "lamb" if order.animal.animal_type == "Lamb"
      @meat_type = "goat" if order.animal.animal_type == "Goat"

    @url  = "www.meatup.in"
    @meat_url = "www.meatup.in/purchase"
    @receipt_url = "www.meatup.in/orders/#{@order.id}"
    @blog_url = "www.meatup.in/how"
    @host_url = "www.meatup.in/hosts/#{@host.id}"
    attachments.inline['meatup_logo_white.png'] = File.read("#{Rails.root}/app/assets/images/meatup_logo_white.png")
    attachments.inline['grassy_knoll_white_sm.png'] = File.read("#{Rails.root}/app/assets/images/grassy_knoll_white_sm.png")
    mail(:to => @user.email, :subject => "Thanks for the Order!")
  end

end
