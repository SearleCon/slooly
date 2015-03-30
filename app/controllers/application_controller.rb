class ApplicationController < ActionController::Base
  include UnobtrusiveFlash, LayoutRequired

  protect_from_forgery

  respond_to :html, :js, :json

  before_action :authenticate_user!
  before_action :validate_subscription, if: :user_signed_in?

  around_action :with_timezone, if: :user_signed_in?

  def recent_announcements
    @recent_announcements ||= Announcement.recent.where.not(id: cookies.signed[:hidden_announcement_ids])
  end
  helper_method :recent_announcements

  private

  def validate_subscription
    redirect_to new_order_url unless current_user.subscribed?
  end

  def with_timezone
    timezone = current_user.time_zone || Time.find_zone(cookies[:timezone])
    Time.use_zone(timezone) { yield }
  end
end
