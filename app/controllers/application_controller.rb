require 'application_responder'

class ApplicationController < ActionController::Base
  include HttpCacheForever

  self.responder = ApplicationResponder
  respond_to :html, :js, :json

  protect_from_forgery

  layout proc { false if request.xhr? }

  before_action :set_announcement, :check_browser_version

  around_action :with_timezone

  etag { [current_user.try(:id), flash] }

  private

  def check_browser_version
    flash.now[:alert] = render_to_string(partial: 'shared/browser_warning') if browser.ie6? || browser.ie7? || browser.ie8?
  end

  def set_announcement
    announcement = Announcement.recent.unread(cookies.permanent.signed[:hidden_announcement_ids]).first
    return unless announcement.present?
    flash.now[:warning] = render_to_string(partial: 'shared/news', locals: { announcement: announcement })
  end

  def authorize_user!
    return if current_user.subscribed?
    redirect_to plans_url
  end

  def with_timezone(&block)
    timezone = current_user.try(:time_zone) || 'UTC'
    Time.use_zone(timezone, &block)
  end
end
