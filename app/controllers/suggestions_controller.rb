class SuggestionsController < ApplicationController
  skip_before_filter  :authenticate_user!, only: [:new, :create]


  load_resource except: [:index]
  authorize_resource except: [:new, :create]

  def index
    @suggestions = Suggestion.all
  end

  def show;end

  def new;end

  def edit;end

  def create
    flash[:notice] = 'Thank you for your comment. We appreciate it!' if @suggestion.save
    respond_with @suggestion, location: root_url
  end

  def update
    flash[:notice] = 'Suggestion was successfully updated.' if @suggestion.update_attributes(params[:suggestion])
    respond_with @suggestion
  end

  def destroy
     @suggestion.destroy
     respond_with @suggestion
  end
  
end
