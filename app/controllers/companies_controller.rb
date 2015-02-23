class CompaniesController < ApplicationController
  before_action :set_company

  def update
    flash[:notice] = t('flash.company.update', resource_name: @company.name.titleize) if @company.update(company_params)
    respond_with @company, location: company_url
  end

  private

  def set_company
    @company = current_user.company
  end

  def company_params
    params.require(:company).permit(:address, :city, :email, :fax, :logo_path, :name, :post_code, :telephone, :image, :remote_image_url)
  end
end
