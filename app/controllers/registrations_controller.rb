class RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate_user!, :validate_subscription


  protected

  def after_sign_up_path_for(_resource)
    initial_setup_path
  end

  def sign_up_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :terms_of_service, :time_zone)
  end

  def account_update_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :current_password, :time_zone)
  end
end
