class SendRemindersJob < ActiveJob::Base
  queue_as :default

  def perform(invoice, history)
    UserMailer.send_it(history).deliver_now
    history.update(sent: true)
    invoice.touch(:last_date_sent)
  end

end
