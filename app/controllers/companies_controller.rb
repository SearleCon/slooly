class CompaniesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_company

  def index;  end

  def edit;
  end


  def update
    flash[:notice] =  'Company was successfully updated.'  if @company.update_attributes(params[:company])
    respond_with @company, location: companies_url
  end


  private
   def set_company
     @company = current_user.company
   end
end
