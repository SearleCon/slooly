class RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def create
    super do |resource|
      if resource.persisted?
        UserSetup.new(resource).call
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
    devise_parameter_sanitizer.for(:sign_up) << :terms_of_service
    devise_parameter_sanitizer.for(:account_update) << :name
  end
end
