class UserMailer < ActionMailer::Base
  default :from => "slooly@example.com"

  def registration_confirmation(user)
    @user = user
    mail(:to => @user.email, :subject => "Slooly Registration Details") #SS Needs to change
  end
end