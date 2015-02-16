class Admin::UsersController < Admin::BaseController
  def index
    @users = User.where(role: User.roles[:user]).page(params[:page])
  end
end