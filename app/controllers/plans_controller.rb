class PlansController < ApplicationController
  before_action :authenticate_user!

  def index
    @plans = Plan.available
  end
end
