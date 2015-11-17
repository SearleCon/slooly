class PagesController < ApplicationController
  def about
    http_cache_forever(public: true) do
      render
    end
  end

  def supported_browsers
    http_cache_forever(public: true) do
      render
    end
  end

  def privacy
    http_cache_forever(public: true) do
      render
    end
  end

  def tos
    http_cache_forever(public: true) do
      render
    end
  end

  def pricing
    http_cache_forever(public: true) do
      render
    end
  end

  def faq
    http_cache_forever(public: true) do
      render
    end
  end

  def tutorial
    http_cache_forever(public: true) do
      render
    end
  end
end
