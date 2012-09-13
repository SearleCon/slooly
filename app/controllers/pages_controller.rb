class PagesController < ApplicationController
  before_filter :authenticate_user!
  helper_method :sort_column, :sort_direction
  
  
  def home
    @chasing_invoices = Invoice.paginate :conditions => ["user_id = ? and status_id = ?", current_user.id, 2],
    :order => (sort_column + ' ' + sort_direction), :page => params[:page], :per_page => 10
  end

  def about
  end

  def contact
  end

  def help
  end
  
  def reports
    @summary = Invoice.all :conditions => ["user_id = ? and status_id = ?", current_user.id, 2]
  end
    
  private
  def sort_column
    Invoice.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"    
  end
  
end
