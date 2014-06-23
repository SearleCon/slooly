class HistoriesController < ApplicationController
  def show
    @history = History.find(params[:id])
    fresh_when @history
  end
end
