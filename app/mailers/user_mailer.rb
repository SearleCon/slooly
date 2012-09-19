class UserMailer < ActionMailer::Base
#  default :from => "YourBusiness"

  def registration_confirmation(user)
    @user = user
    mail(:from => "registrations@slooly.com", :to => @user.email, :subject => "Slooly Registration Details") 
  end
  
  def send_it(history)
    @historysend = history
#    mail(:to => @historysend.email_sent_to, :subject => @historysend.subject)     
    mail(:from => @historysend.email_sent_from, :to => @historysend.email_sent_to, :bcc => @historysend.copy_email, :subject => @historysend.subject)     
  end
end