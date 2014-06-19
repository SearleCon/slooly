class SuggestionsController < ApplicationController
  skip_before_filter  :authenticate_user!, only: [:new, :create]
  before_filter :authorize, except: [:new, :create]
  before_filter :set_suggestion, only: [:show, :edit, :update, :destroy]


  def index
    @suggestions = Suggestion.all
  end


  def new
   @suggestion = Suggestion.new
  end


  def create
    @suggestion = Suggestion.new(suggestion_params)
    flash[:notice] = 'Thank you for your comment. We appreciate it!' if @suggestion.save
    respond_with @suggestion, location: root_url
  end

  def update
    flash[:notice] = 'Suggestion was successfully updated.' if @suggestion.update_attributes(suggestion_params)
    respond_with @suggestion
  end

  def destroy
     @suggestion.destroy
     respond_with @suggestion
  end

  private
  def set_suggestion
    @suggestion = Suggestion.find(params[:id])
  end

  def suggestion_params
    params.require(:suggestion).permit(:comment, :email, :subject)
  end

  def authorize
    redirect_to root_url, alert: 'You are not authorized to perform this action' unless current_user.has_role? :admin
  end
  
end
