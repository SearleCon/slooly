class ImpersonationsController < ApplicationController
  skip_before_action :validate_subscription
  before_action :authorize!, only: :create
  before_action :set_user, only: :create
  before_action :set_admin, only: :destroy


  def create
    session[:current_admin] = current_user.id
    sign_out current_user
    sign_in @user
    redirect_to root_url, notice: t('flash.impersonations.create', name: @user.name)
  end

  def destroy
    if session[:current_admin].present?
      sign_out current_user if user_signed_in?
      sign_in @admin
      flash[:notice] = t('flash.impersonations.destroy')
    end
    redirect_to root_url
  end


  private
  def authorize!
    redirect_to root_url, alert: t('flash.application.unauthorized') unless current_user.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_admin
    @admin = User.find(session.delete(:current_admin))
  end
end