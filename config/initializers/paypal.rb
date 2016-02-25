require 'paypal/recurring'


PayPal::Recurring.configure do |config|
  config.sandbox = Rails.application.config_for(:paypal)['sandbox']
  config.username = Rails.application.config_for(:paypal)['username']
  config.password = Rails.application.config_for(:paypal)['password']
  config.signature = Rails.application.config_for(:paypal)['signature']
end
