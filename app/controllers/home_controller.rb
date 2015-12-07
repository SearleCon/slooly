class HomeController < ApplicationController
  def index
    fresh_when('home', public: true)
  end
end
