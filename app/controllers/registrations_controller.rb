class RegistrationsController < Devise::RegistrationsController
  skip_before_filter  :authenticate_user!


  def create
    super do |resource|
      if resource.persisted?
        UserSetup.new(resource).call
        UserMailer.delay.registration_confirmation(resource)
      end
    end
  end

  protected
    def after_sign_up_path_for(resource)
      pages_initial_setup_path
    end

end