class PagesController < ApplicationController

  def about
    fresh_when('about', public: true)
  end

  def supported_browsers
    fresh_when('supported browsers', public: true)
  end

  def privacy
    fresh_when('privacy', public: true)
  end

  def tos
    fresh_when('tos', public: true)
  end

  def pricing
    fresh_when('pricing', public: true)
  end

  def faq
    fresh_when('faq', public: true)
  end

  def tutorial
    fresh_when('tutorial', public: true)
  end
end
