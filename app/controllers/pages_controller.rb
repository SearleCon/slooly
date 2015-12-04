class PagesController < ApplicationController

  def about
    http_cache_forever { render }
  end

  def supported_browsers
    http_cache_forever { render }
  end

  def privacy
    http_cache_forever { render }
  end

  def tos
    http_cache_forever { render }
  end

  def pricing
    http_cache_forever { render }
  end

  def faq
    http_cache_forever { render }
  end

  def tutorial
    http_cache_forever { render }
  end
end
