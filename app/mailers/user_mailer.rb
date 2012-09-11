class UserMailer < ActionMailer::Base
  default :from => "slooly@example.com"

  def registration_confirmation(user)
    mail(:to => "shaun.searle@gmail.com", :subject => "Registered") #SS Needs to change
  end
end
