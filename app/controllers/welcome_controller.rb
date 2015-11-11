class WelcomeController < ApplicationController
  before_action :authenticate_user!
  before_action :confirm_subscription!


  def index
  end
end
