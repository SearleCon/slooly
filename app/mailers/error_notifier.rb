class ErrorNotifier < ActionMailer::Base
  default from: 'from@example.com'

  def notify(exception_name, message, backtrace)
    @exception_name = exception_name
    @message = message
    @backtrace = backtrace
    mail(
      to: 'support@searleconsulting.co.za',
      subject: 'Paying Mantis Error'
    )
  end
end
