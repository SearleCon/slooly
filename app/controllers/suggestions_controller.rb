class SuggestionsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @suggestion = Suggestion.new(suggestion_params)
  end

  def create
    @suggestion = Suggestion.new(suggestion_params)
    flash[:notice] = t("flash.suggestions.create") if @suggestion.save
    respond_with @suggestion, location: root_url
  end

  private
  def suggestion_params
    params.fetch(:suggestion, {}).permit(:comment, :email, :subject)
  end
end
