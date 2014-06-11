class ApplicationController < ActionController::Base
  respond_to :html, :js, :json
  protect_from_forgery


  before_filter :authenticate_user!
  before_filter :subscription_required

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  # SS Not found and Routing error redirects
  rescue_from ActionController::RoutingError, with: :render_not_found
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def routing_error
    raise ActionController::RoutingError.new(params[:path])
  end

  def render_not_found
    render '/pages/not_found'
  end

  def subscription_required
    if user_signed_in?
      redirect_to payment_plans_subscriptions_url if current_user.active_subscription.has_expired?
    end
  end

end