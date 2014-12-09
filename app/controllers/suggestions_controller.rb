class SuggestionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  before_action :authorize, except: [:new, :create]
  before_action :set_suggestion, only: [:destroy]
  before_action :build_suggestion, only: [:new, :create]

  def index
    @suggestions = Suggestion.all
  end

  def create
    flash[:notice] = 'Thank you for your comment. We appreciate it!' if @suggestion.save
    respond_with @suggestion, location: root_url
  end

  def destroy
    @suggestion.destroy
    respond_with @suggestion
  end

  private

  def set_suggestion
    @suggestion = Suggestion.find(params[:id])
  end

  def build_suggestion
    @suggestion = Suggestion.new(suggestion_params)
  end

  def suggestion_params
    params.fetch(:suggestion, {}).permit(:comment, :email, :subject)
  end

  def authorize
    redirect_to root_url, alert: 'You are not authorized to perform this action' unless current_user.admin?
  end
end
