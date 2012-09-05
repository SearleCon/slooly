class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def after_sign_in_path_for(resource) #SS This is the redirect after login
    user_path(resource)
    # '/an/example/path'
  end
  
  def after_sign_out_path_for(resource)
    new_suggestion_path #SS This is for the logout redirect after Logout for the suggestion screen
  end

end