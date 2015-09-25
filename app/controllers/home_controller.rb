class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
   fresh_when(['homepage', flash], public: true)
  end
end
