class Admins::SuggestionsController < Admins::BaseController
  before_action :set_suggestion, except: :index

  def index
    @suggestions = Suggestion.all
  end

  def destroy
    @suggestion.destroy
    respond_with @suggestion, location: admins_suggestions_url
  end

  private

  def set_suggestion
    @suggestion = Suggestion.find(params[:id])
  end
end
