class HistoriesController < ApplicationController


  before_action :authenticate_user!
  before_action :confirm_subscription!

  decorates_assigned :history

  def show
    @history = History.find(params[:id])
    fresh_when @history
  end
end
