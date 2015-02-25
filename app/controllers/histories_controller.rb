class HistoriesController < ApplicationController
  decorates_assigned :history

  def show
    @history = History.find(params[:id])
    fresh_when @history
  end
end
