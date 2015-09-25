require "paypal/recurring"


if Rails.env.development?
  PayPal::Recurring.configure do |config|
    config.sandbox = true
    config.username = 'pauljansevan-facilitator_api1.gmail.com'
    config.password = '1397550977'
    config.signature = 'AFcWxV21C7fd0v3bYYYRCpSSRl31AbfomKHlXmSj.I4y4rVRJfeorgjG'
  end
else
  PayPal::Recurring.configure do |config|
    config.sandbox = false
    config.username = Rails.application.secrets.paypal_username
    config.password = Rails.application.secrets.paypal_password
    config.signature = Rails.application.secrets.paypal_signature
  end
end


