class UserMailer < ActionMailer::Base
  default :from => "slooly@example.com"

  def registration_confirmation(user)
    @user = user
    mail(:to => @user.email, :subject => "Slooly Registration Details") 
  end
  
  def send_it(history)
    @historysend = history
    mail(:to => "shaun.searle@gmail.com", :subject => @historysend.subject)     
  end
end