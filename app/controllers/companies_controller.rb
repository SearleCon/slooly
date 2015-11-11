class CompaniesController < ApplicationController

  before_action :authenticate_user!
  before_action :confirm_subscription!

  before_action :set_company

  def update
    flash[:notice] = t('flash.company.update', resource_name: @company.name.titleize) if @company.update(company_params)
    respond_with @company, location: company_url
  end

  private

  def set_company
    @company = Company.find_by(user_id: current_user.id)
  end

  def company_params
    params.require(:company).permit(:address, :city, :email, :fax, :logo_path, :name, :post_code, :telephone, :image, :remote_image_url).merge(user: current_user)
  end
end
