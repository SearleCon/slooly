class CompaniesController < ApplicationController
  before_action :set_company

  def update
    flash[:notice] = "#{@company.name.titleize} was successfully updated." if @company.update(company_params)
    redirect_to company_url
  end

  private

  def set_company
    @company = current_user.company
  end

  def company_params
    params.require(:company).permit(:address, :city, :email, :fax, :logo_path, :name, :post_code, :telephone, :image, :remote_image_url)
  end
end
