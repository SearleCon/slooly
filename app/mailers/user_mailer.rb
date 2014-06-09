class UserMailer < ActionMailer::Base
#  default :from => "YourBusiness"

  def registration_confirmation(user)
    @user = user
    mail(:from => "registrations@payingmantis.com", :to => @user.email, :subject => "Paying Mantis - Registration Details") 
  end
  
  def send_it(history)
    @historysend = history
#    mail(:to => @historysend.email_sent_to, :subject => @historysend.subject)     
    mail(:from => @historysend.email_sent_from, :to => @historysend.email_sent_to, :bcc => @historysend.copy_email, :subject => @historysend.subject)     
  end
  
  def new_message(message)
      @message = message
      mail(:from => message.email, :to => "support@searleconsulting.co.za", :subject => "Contact Us Notification: #{message.subject}")
  end
  
end