class Admins::SessionsController < Devise::SessionsController
  layout 'admin'

  skip_before_action :authenticate_admin!

  protected

  def after_sign_in_path_for(_resource)
    root_url
  end
end
