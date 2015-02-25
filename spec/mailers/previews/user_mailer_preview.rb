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
    invoice = Invoice.last
    reminder = Invoice::Reminders.new(invoice)
    history = History.new(subject: reminder.subject,
                          message: reminder.text,
                          email_sent_from: reminder.sender,
                          copy_email: reminder.cc,
                          email_sent_to: reminder.recipient)
    UserMailer.send_it(history)
  end
end