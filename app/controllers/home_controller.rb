class HomeController < ApplicationController
  def index
    http_cache_forever { render }
  end
end
