class Admin::SuggestionsController < Admin::BaseController
  before_action :set_suggestion, except: :index

  def index
    @suggestions = Suggestion.all
  end

  def create
    flash[:notice] = t("flash.suggestions.create") if @suggestion.save
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
end