class UsersController < ApplicationController
  before_action :authorize, only: [:show]

  def show
    @user = User.find(params[:id])
  end

  private

  def authorize
    redirect_to root_url, alert: t('flash.application.unauthorized') unless current_user.admin?
  end
end
