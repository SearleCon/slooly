class ImpersonationsController < ApplicationController
  skip_before_action :authenticate_user!, :validate_subscription
  before_action :authenticate_admin!, only: :create
  before_action :set_user, only: :create
  before_action :set_admin, only: :destroy


  def create
    session[:current_admin] = current_admin.id
    sign_out current_admin
    sign_in :user, @user
    redirect_to user_root_url, notice: t('flash.impersonations.create', name: @user.name)
  end

  def destroy
    sign_out(current_user)if user_signed_in?
    if session[:current_admin].present?
      sign_in(:admin, @admin)
      session.delete(:current_admin)
    end
    redirect_to admin_root_url, notice: t('flash.impersonations.destroy')
  end


  private
  def set_user
    @user = User.find(params[:id])
  end

  def set_admin
    @admin = Admin.find(session[:current_admin])
  end
end