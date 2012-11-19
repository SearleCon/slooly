class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :subscription_required

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def after_sign_in_path_for(resource) #SS This is the redirect after login
     # user_path(resource) 
     if (Setting.for_user(current_user.id).empty?) or (Company.by_user(current_user.id).empty?)
       # new_setting_path
       '/pages/initial_setup'
     else
       '/pages/home'
     end
  end
  
  def after_sign_out_path_for(resource)
    new_suggestion_path #SS This is for the logout redirect after Logout for the suggestion screen
  end
  
  
# SS Not found and Routing error redirects
  rescue_from ActionController::RoutingError, :with => :render_not_found
  rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found

  def routing_error
    raise ActionController::RoutingError.new(params[:path])
  end

  def render_not_found
    render "/pages/not_found"
  end

  def subscription_required
    unless current_user.nil?
      if current_user.active_subscription && current_user.active_subscription.has_expired?
        redirect_to payment_plans_subscriptions_url
      end
    end
  end

end