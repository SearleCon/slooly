class Admin::UsersController < Admin::BaseController
  def index
    @users = User.where(role: User.roles[:user]).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end
end