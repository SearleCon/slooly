if Rails.env.development?

  class EmailInterceptor
    def self.delivering_email(message)
      message.to = ['paul@searleconsulting.co.za']
    end
  end

  ActionMailer::Base.register_interceptor(EmailInterceptor)
end