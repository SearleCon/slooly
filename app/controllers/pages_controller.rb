class PagesController < ApplicationController
  def about
    expires_in 100.years, public: true
    if stale?(etag: 'about',  last_modified: Time.parse('2011-01-01').utc, public: true)
      render
    end
  end

  def privacy
    expires_in 100.years, public: true
    if stale?(etag: 'privacy',  last_modified: Time.parse('2011-01-01').utc, public: true)
      render
    end
  end

  def tos
    expires_in 100.years, public: true
    if stale?(etag: 'terms_of_service',  last_modified: Time.parse('2011-01-01').utc, public: true)
      render
    end
  end

  def pricing
    expires_in 100.years, public: true
    if stale?(etag: 'pricing',  last_modified: Time.parse('2011-01-01').utc, public: true)
      render
    end
  end

  def faq
    expires_in 100.years, public: true
    if stale?(etag: 'faq',  last_modified: Time.parse('2011-01-01').utc, public: true)
      render
    end
  end

  def tutorial
    expires_in 100.years, public: true
    if stale?(etag: 'tutorial',  last_modified: Time.parse('2011-01-01').utc, public: true)
      render
    end
  end
end
