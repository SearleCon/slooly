require "paypal/recurring"


  PayPal::Recurring.configure do |config|
    config.sandbox = true
    config.username = 'pauljansevan-facilitator_api1.gmail.com'
    config.password = '1397550977'
    config.signature = 'AFcWxV21C7fd0v3bYYYRCpSSRl31AbfomKHlXmSj.I4y4rVRJfeorgjG'
  end
  # PayPal::Recurring.configure do |config|
  #   config.sandbox = false
  #   config.username = ENV["PAYPAL_USERNAME"]
  #   config.password = ENV["PAYPAL_PASSWORD"]
  #   config.signature = ENV["PAYPAL_SIGNATURE"]
  # end
