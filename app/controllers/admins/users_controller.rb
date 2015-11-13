class Admins::UsersController < Admins::BaseController
  def index
    @users = User.includes(subscription: :plan).all.order(last_sign_in_at: :desc).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end
end
