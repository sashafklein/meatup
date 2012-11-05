class UserMailer < ActionMailer::Base
  default from: "Meatup <no_reply@meatup.in>"

  def welcome_email(user)
    @user = user
    @url  = "www.meatup.in"
    @meat_url = "www.meatup.in/orders/purchase"
    attachments.inline['meatup_logo_white.png'] = File.read("#{Rails.root}/app/assets/images/meatup_logo_white.png")
    attachments.inline['grassy_knoll_white_sm.png'] = File.read("#{Rails.root}/app/assets/images/grassy_knoll_white_sm.png")
    mail(:to => user.email, :subject => "Welcome to MeatUp!")
  end

  def order_email(order)
  	@user = order.user
  	@order = order
    @host = order.animal.host
    @animal = order.animal
    @meat_type = @animal.meat_type

    @url  = "www.meatup.in"
    @meat_url = "www.meatup.in/purchase"
    @receipt_url = "www.meatup.in/orders/#{order.id}"
    @blog_url = "www.meatup.in/how"
    @host_url = "www.meatup.in/hosts/#{@host.id}"
    attachments.inline['meatup_logo_white.png'] = File.read("#{Rails.root}/app/assets/images/meatup_logo_white.png")
    attachments.inline['grassy_knoll_white_sm.png'] = File.read("#{Rails.root}/app/assets/images/grassy_knoll_white_sm.png")
    mail(:to => @user.email, :subject => "Thanks for the Order!")
  end

  def to_finalize(animal)
    @users = animal.users
    @url  = "www.meatup.in"
    attachments.inline['meatup_logo_white.png'] = File.read("#{Rails.root}/app/assets/images/meatup_logo_white.png")
    attachments.inline['grassy_knoll_white_sm.png'] = File.read("#{Rails.root}/app/assets/images/grassy_knoll_white_sm.png")
    @users.each do |u|
      u.animal_orders(animal).each do |o|
        @o = o
        @u = u
        @receipt_url = "www.meatup.in/orders/#{o.id}"
        mail(to: u.email, subject: "Update and finalize your meat order!")
      end
    end
  end

  def finalized_order(order)
    @user = order.user
    @order = order
    @host = order.animal.host
    @animal = order.animal
    @meat_type = @animal.meat_type

    @url  = "www.meatup.in"
    @meat_url = "www.meatup.in/purchase"
    @receipt_url = "www.meatup.in/orders/#{order.id}"
    @blog_url = "www.meatup.in/how"
    @host_url = "www.meatup.in/hosts/#{@host.id}"
    attachments.inline['meatup_logo_white.png'] = File.read("#{Rails.root}/app/assets/images/meatup_logo_white.png")
    attachments.inline['grassy_knoll_white_sm.png'] = File.read("#{Rails.root}/app/assets/images/grassy_knoll_white_sm.png")
    mail(:to => @user.email, :subject => "Order payment updated!")
  end

  def animal_overview(animal)
    @url  = "www.meatup.in"
    @label_url = "www.meatup.in/animals/#{animal.id}/labels"
    attachments.inline['meatup_logo_white.png'] = File.read("#{Rails.root}/app/assets/images/meatup_logo_white.png")
    attachments.inline['grassy_knoll_white_sm.png'] = File.read("#{Rails.root}/app/assets/images/grassy_knoll_white_sm.png")
    User.where(:admin => true) do |u|
      mail(:to => u.email, :subject => "#{animal.name} has closed!")
    end
  end

  def butcher_specs(animal)
    @url  = "www.meatup.in"
    @label_url = "www.meatup.in/animals/#{animal.id}/labels"
    @log_url = "www.meatup.in/butchers/#{animal.butcher.id}/log/#{animal.id}"
    attachments.inline['meatup_logo_white.png'] = File.read("#{Rails.root}/app/assets/images/meatup_logo_white.png")
    attachments.inline['grassy_knoll_white_sm.png'] = File.read("#{Rails.root}/app/assets/images/grassy_knoll_white_sm.png")
    @user = animal.butcher.user
    mail(:to => @user.email, :subject => "#{animal.name}'s Butchery Instructions are ready!")
  end

  def animal_close(animal)
    @users = animal.users
    @url  = "www.meatup.in"
    attachments.inline['meatup_logo_white.png'] = File.read("#{Rails.root}/app/assets/images/meatup_logo_white.png")
    attachments.inline['grassy_knoll_white_sm.png'] = File.read("#{Rails.root}/app/assets/images/grassy_knoll_white_sm.png")
    @users.each do |u|
      mail(to: u.email, subject: "Your #{animal.meat_type} is on the move")
    end
  end



end
