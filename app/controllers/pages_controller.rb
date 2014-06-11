class PagesController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:about, :pricing, :faq, :tos, :privacy, :ie_warning]

  helper_method :sort_column, :sort_direction
  
  
  def home
    @chasing_invoices = current_user.invoices.chasing.order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => 10)
  end

  def about;end

  def faq;end

  
  def pricing;end

  def tos;end

  def privacy;end

  def tutorial;end


  def reports
    @summary_report = SummaryReport.new(current_user.invoices.chasing)
  end
    
  private
  def sort_column
    Invoice.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"    
  end
  
end
