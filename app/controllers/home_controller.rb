class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    http_cache_forever(public: true) do
      render
    end
  end
end
