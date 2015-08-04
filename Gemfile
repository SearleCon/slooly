source 'https://rubygems.org'

gem 'rails', '~> 4.2.1'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'sass-rails',   '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'jbuilder'
gem 'responders', '~> 2.0'

#Frontend
gem 'bootstrap-sass', '~> 2.3.2.2'
gem 'bootstrap-datetimepicker-rails'
gem 'twitter-bootstrap-rails-confirm'
gem "font-awesome-rails"
gem 'bootstrap_sortable_rails'
gem 'nprogress-rails'

# Decorators
gem 'draper', '~> 1.3'

# Authentication
gem 'devise'

# File uploads
gem "carrierwave"

# Pagination
gem 'will_paginate', '~> 3.0.6'

# Background Processing
gem 'delayed_job_active_record'
gem "workless", "~> 1.2.3"

# Turbolinks
gem 'turbolinks'

# Paypal
gem "paypal-recurring"

# Misc
gem "browser"
gem 'metamagic'
gem 'honeypot-captcha'


# Obfuscate emails
gem 'obfuscatejs'

# Resize text areas
gem 'autosize-rails'

# relative time display
gem 'local_time'

# import from excel
gem 'active_importer'

# Templating
gem 'slim-rails'

# Email css
gem 'premailer-rails'

# Postgres
gem 'pg'

# Configuration
gem 'figaro'

# Coupon Codes
gem 'coupon_code'

# Memcached client
gem 'dalli'

source 'https://rails-assets.org' do
  # Cookie handler
  gem 'rails-assets-jquery-cookie'

  # Validation
  gem 'rails-assets-jquery-validate'

  # Time zone detection
  gem 'rails-assets-jsTimezoneDetect'
end

# Server
gem 'puma'

group :production do
  gem 'heroku-deflater'
  gem 'rails_12factor'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rspec'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'annotate'
  gem 'quiet_assets'
  gem 'rubocop', require: false
  gem 'bullet'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
end
