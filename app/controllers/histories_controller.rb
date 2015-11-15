class HistoriesController < ApplicationController


  before_action :authenticate_user!
  before_action :confirm_subscription!

  def show
    @history = decorate(History.find(params[:id]))
    fresh_when @history
  end
end
