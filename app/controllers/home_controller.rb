class HomeController < ApplicationController

  def index
    http_cache_forever(public: true) do
      render
    end
  end
end
