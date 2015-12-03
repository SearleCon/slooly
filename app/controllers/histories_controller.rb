class HistoriesController < ApplicationController

  before_action :authenticate_user!, :authorize_user!

  def show
    @history = History.find(params[:id])
    fresh_when @history
  end
end
