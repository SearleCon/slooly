class Admins::SuggestionsController < Admins::BaseController
  responders :collection

  before_action :set_suggestion, except: :index

  def index
    @suggestions = Suggestion.all
  end

  def destroy
    @suggestion.destroy
    respond_with :admins, @suggestion
  end

  private

  def set_suggestion
    @suggestion = Suggestion.find(params[:id])
  end
end
