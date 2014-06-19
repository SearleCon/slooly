source 'https://rubygems.org'

gem 'rails', '3.2.17'
gem 'jquery-rails'

#Frontend
gem "bootstrap-sass", "~> 2.0.4.2"
gem "bootstrap-datepicker-rails"


# Authentication
gem 'devise', '~> 3.2.4'

# Authorization
gem "rolify", ">= 3.2.0"

# In place editing
gem "best_in_place"

# File uploads
gem "carrierwave"

# Pagination
gem 'will_paginate', '3.0.3'

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

# Strong params
gem 'strong_parameters'


group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :production do
  gem 'pg'
end

group :development, :test do
  gem "factory_girl_rails", ">= 4.0.0"
  gem "rspec-rails", ">= 2.11.0"
  gem 'sqlite3'
end

group :development do
  gem 'annotate'
  gem 'quiet_assets'
end

group :test do
  gem "capybara", ">= 1.1.2"
  gem "email_spec", ">= 1.2.1"
  gem "cucumber-rails", ">= 1.3.0", :require => false
  gem "database_cleaner", ">= 0.8.0"
  gem "launchy", ">= 2.1.2"
end