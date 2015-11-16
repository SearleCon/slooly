class ApplicationController < ActionController::Base
  respond_to :html, :js, :json

  protect_from_forgery

  layout proc { false if request.xhr? }

  before_action :set_announcement

  around_action :with_timezone

  etag { [current_user.try(:id), flash] }

  def http_cache_forever(public: false, version: 'v1')
   expires_in 100.years, public: public
   yield if stale?(etag: "#{version}-#{request.fullpath}-#{flash.to_a.join(',')}", last_modified: Time.parse('2011-01-01').utc, public: public)
  end

  private

  def set_announcement
    announcement = Announcement.recent.unread(cookies.permanent.signed[:hidden_announcement_ids]).first
    flash.now[:warning] = render_to_string(partial: 'layouts/breaking_news', locals: {announcement: announcement}) if announcement.present?
  end

  def confirm_subscription!
    redirect_to new_order_url if current_user.subscription.expired?
  end

  def with_timezone(&block)
    timezone = current_user.try(:time_zone) || 'UTC'
    Time.use_zone(timezone, &block)
  end
end
