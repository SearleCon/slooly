source 'https://rubygems.org'

gem 'rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'sass-rails',   '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'

#Frontend
gem "bootstrap-sass", "~> 2.0.4.2"
gem "bootstrap-datepicker-rails"


# Authentication
gem 'devise', '~> 3.2.4'
gem 'devise-async'

# Authorization
gem "rolify", ">= 3.2.0"

# In place editing
#gem "best_in_place"

# File uploads
gem "carrierwave"

# Pagination
gem 'will_paginate', '~> 3.0'

# Background Processing
gem 'delayed_job_active_record'
gem "workless", "~> 1.2.3"


# Turbolinks
gem "jquery-turbolinks"

# Paypal
gem "paypal-recurring"

# Misc
gem "browser"
gem 'metamagic'
gem 'honeypot-captcha'

# Excel
gem 'roo'

# Server
gem 'unicorn'

# Obfuscate emails
gem 'obfuscatejs'

# Searching
gem "ransack"

group :production do
  gem 'pg'
  gem 'heroku-deflater'
  gem 'rails_12factor'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'faker'
end

group :development do
  gem 'spring'
  gem 'annotate'
  gem 'quiet_assets'
  gem 'rails_apps_testing'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
end
