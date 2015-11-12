class ErrorNotifier < ActionMailer::Base
  default from: 'exceptions@payingmantis.com'

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
