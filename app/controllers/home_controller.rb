class HomeController < ApplicationController
  def index
    expires_in 100.years, public: true
    if stale?(etag: 'home',  last_modified: Time.parse('2011-01-01').utc, public: true)
      render 
    end
  end
end
