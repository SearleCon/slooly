class ApplicationController < ActionController::Base
  respond_to :html, :js, :json
  protect_from_forgery
  before_filter :subscription_required

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  
  
# SS Not found and Routing error redirects
  rescue_from ActionController::RoutingError, :with => :render_not_found
  rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found

  def routing_error
    raise ActionController::RoutingError.new(params[:path])
  end

  def render_not_found
    render '/pages/not_found'
  end

  def subscription_required
    unless current_user.nil?
      if current_user.active_subscription && current_user.active_subscription.has_expired?
        redirect_to payment_plans_subscriptions_url
      end
    end
  end

  def setup_required?
    !current_user.setting && !current_user.company
  end

end