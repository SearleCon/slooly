class HistoriesController < ApplicationController
  def show
    @history = current_user.histories.find(params[:id])
  end
end
