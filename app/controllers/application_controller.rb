class ApplicationController < ActionController::Base
  include UnobtrusiveFlash
  include LayoutRequired

  protect_from_forgery

  respond_to :html, :js, :json

  before_action :authenticate_user!
  before_action :validate_subscription, if: :user_signed_in?

  around_action :with_timezone, if: :user_signed_in?

  def recent_announcements
    @recent_announcements ||= Announcement.recent
  end
  helper_method :recent_announcements

  private

  def validate_subscription
    redirect_to payment_plans_subscriptions_url if current_user.subscription_has_expired?
  end

  def with_timezone
    timezone = current_user.time_zone || Time.find_zone(cookies[:timezone])
    Time.use_zone(timezone) { yield }
  end
end
