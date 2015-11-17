class SuggestionsController < ApplicationController

  def new
    @suggestion = Suggestion.new(suggestion_params)
  end

  def create
    @suggestion = Suggestion.new(suggestion_params)
    flash[:notice] = 'Thank you for your comment. We appreciate it!' if @suggestion.save
    respond_with @suggestion, location: root_url
  end

  private

  def suggestion_params
    params.fetch(:suggestion, {}).permit(:comment, :email, :subject)
  end
end
