ENV['RAILS_CACHE_ID'] = ENV['HEROKU_SLUG_COMMIT'] if Rails.env.production?
