class UserMailerPreview < ActionMailer::Preview
  def registration_confirmation
    user = FactoryGirl.build(:user)
    UserMailer.registration_confirmation(user)
  end

  def new_message
    message = Message.new(name: Faker::Name.first_name, email: Faker::Internet.email, subject: Faker::Lorem.words(2).join(' '), body: Faker::Lorem.paragraph)
    UserMailer.new_message(message)
  end

  def send_it
    history = History.last
    UserMailer.send_it(history)
  end
end