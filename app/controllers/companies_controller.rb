# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string(255)      default("Your Company Name")
#  address    :string(255)      default("44 Street Name, Suburb")
#  city       :string(255)      default("Best City")
#  post_code  :string(255)      default("1234")
#  telephone  :string(255)      default("555 345 6789")
#  fax        :string(255)      default("People still fax?")
#  email      :string(255)      default("you@example.com")
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CompaniesController < ApplicationController
  before_action :authenticate_user!, :authorize_user!

  before_action :set_company

  def show
    fresh_when @company 
  end

  def update
    @company.update(company_params)
    respond_with @company, location: company_url
  end

  private

  def interpolation_options
    { resource_name: @company.name }
  end

  def set_company
    @company = current_user.company
  end

  def company_params
    params.require(:company).permit(:address, :city, :email, :fax, :name, :post_code, :telephone).merge(user_id: current_user.id)
  end
end
