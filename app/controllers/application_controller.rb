class ApplicationController < ActionController::Base
  include UnobtrusiveFlash
  include LayoutRequired

  respond_to :html, :js, :json
  protect_from_forgery

  before_action :authenticate_user!
  before_action :validate_subscription, if: :user_signed_in?

  around_action :with_timezone, if: :user_signed_in?

  private

  def validate_subscription
    redirect_to payment_plans_subscriptions_url if current_user.subscription_has_expired?
  end

  def with_timezone
    timezone = current_user.time_zone || Time.find_zone(cookies[:timezone])
    Time.use_zone(timezone) { yield }
  end
end
