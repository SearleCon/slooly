class HistoriesController < ApplicationController
  before_filter :authenticate_user!


  # GET /histories/1
  # GET /histories/1.json
  def show
    @history = current_user.histories.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @history }
    end
  end
end
