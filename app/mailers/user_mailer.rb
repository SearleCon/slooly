class UserMailer < ActionMailer::Base
  def registration_confirmation(user)
    @user = user
    mail(from: 'registrations@payingmantis.com', to: @user.email, subject: 'Paying Mantis - Registration Details')
  end

  def send_it(history)
    @message = history.message
    mail(from: history.email_sent_from, to: history.email_sent_to, bcc: history.copy_email, subject: history.subject)
  end

  def new_message(message)
    @message = message
    mail(from: message.email, to: 'support@searleconsulting.co.za', subject: "Contact Us Notification: #{message.subject}")
  end
end
