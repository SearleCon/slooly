class SuggestionsController < ApplicationController
  # GET /suggestions
  # GET /suggestions.json
  def index
    if current_user.has_role? :admin
      @suggestions = Suggestion.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @suggestions }
      end
    else
      redirect_to("/pages/not_found")
    end
  end

  # GET /suggestions/1
  # GET /suggestions/1.json
  def show
    if current_user.has_role? :admin
      @suggestion = Suggestion.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @suggestion }
      end
    else
      redirect_to("/pages/not_found")      
    end
  end

  # GET /suggestions/new
  # GET /suggestions/new.json
  def new
    @suggestion = Suggestion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @suggestion }
    end
  end

  # GET /suggestions/1/edit
  def edit
    if current_user.has_role? :admin
      @suggestion = Suggestion.find(params[:id])
    else
      redirect_to("/pages/not_found")            
    end
  end

  # POST /suggestions
  # POST /suggestions.json
  def create
    @suggestion = Suggestion.new(params[:suggestion])

    respond_to do |format|
      if @suggestion.save
        format.html { redirect_to root_path, notice: 'Thank you for your comment. We appreciate it!' }
        format.json { render json: @suggestion, status: :created, location: @suggestion }
      else
        format.html { render action: "new" }
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /suggestions/1
  # PUT /suggestions/1.json
  def update
    if current_user.has_role? :admin    
      @suggestion = Suggestion.find(params[:id])

      respond_to do |format|
        if @suggestion.update_attributes(params[:suggestion])
          format.html { redirect_to @suggestion, notice: 'Suggestion was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @suggestion.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to("/pages/not_found")            
    end
  end

  # DELETE /suggestions/1
  # DELETE /suggestions/1.json
  def destroy
    if current_user.has_role? :admin      
      @suggestion = Suggestion.find(params[:id])
      @suggestion.destroy

      respond_to do |format|
        format.html { redirect_to suggestions_url }
        format.json { head :no_content }
      end
    else
      redirect_to("/pages/not_found")            
    end
  end
  
end
