class PagesController < ApplicationController
  before_filter :authenticate_user!
  helper_method :sort_column, :sort_direction
  
  
  def home
  end

  def about
  end

  def contact
  end

  def help
  end
end
