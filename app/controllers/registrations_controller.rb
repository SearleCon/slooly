class RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

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

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_up) << :time_zone
    devise_parameter_sanitizer.for(:sign_up) << :terms_of_service
    devise_parameter_sanitizer.for(:account_update) << :name
    devise_parameter_sanitizer.for(:account_update) << :time_zone
  end
end
