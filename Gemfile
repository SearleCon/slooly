source 'https://rubygems.org'

ruby '2.2.3'

gem 'rails', '~> 4.2'
gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'

#Frontend
gem 'bootstrap-sass', '~> 2.3.2.2'
gem "font-awesome-rails"

# Authentication
gem 'devise'


# Pagination
gem 'kaminari'

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

# import from excel
gem 'active_importer'

# Templating
gem 'slim-rails'

# Email css
gem 'premailer-rails'

# Postgres
gem 'pg'

# Coupon Codes
gem 'coupon_code'

# Caching
gem 'dalli'
gem 'multi_fetch_fragments'


source 'https://rails-assets.org' do
  gem 'rails-assets-jquery'
  gem 'rails-assets-jquery-ujs'
  gem 'rails-assets-bootstrap-datepicker'
  gem 'rails-assets-jquery-validate'
  gem 'rails-assets-sortable'
  gem 'rails-assets-timeago'
end

# Server
gem 'puma'

group :production do
  gem "rack-timeout"
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
  gem 'annotate'
  gem 'quiet_assets'
  gem 'bullet'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 2.8'
end
