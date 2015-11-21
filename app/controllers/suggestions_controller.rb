class SuggestionsController < ApplicationController
  def new
    @suggestion = Suggestion.new
  end

  def create
    @suggestion = Suggestion.create(suggestion_params)
    respond_with @suggestion, location: root_url
  end

  private

  def suggestion_params
    params.fetch(:suggestion).permit(:comment, :email, :subject)
  end
end
