class RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate_user!

  def create
    super do
      if resource.valid?
        resource.transaction do
          resource.create_company!
          resource.create_setting!
          resource.subscriptions.create!(plan: Plan.free_trial, active: true)
        end
        UserMailer.delay.registration_confirmation(resource)
      end
    end
  end

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
