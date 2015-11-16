class ApplicationController < ActionController::Base
  respond_to :html, :js, :json

  protect_from_forgery

  layout proc { false if request.xhr? }

  before_action :set_announcement, :check_browser_version


  around_action :with_timezone

  etag { [current_user.try(:id), flash] }

  def http_cache_forever(public: false, version: 'v1')
   expires_in 100.years, public: public
   yield if stale?(etag: "#{version}-#{request.fullpath}-#{flash.to_a.join(',')}", last_modified: Time.parse('2011-01-01').utc, public: public)
  end

  private
  def check_browser_version
   if browser.ie6? || browser.ie7? || browser.ie8?
     flash.now[:alert] = %Q{
                            <strong>WARNING: You're running an older version of Internet Explorer that is not fully supported.
                            For more information, please click #{view_context.link_to('here', supported_browsers_path)}</strong>
                           }.html_safe
   end
  end

  def set_announcement
    announcement = Announcement.recent.unread(cookies.permanent.signed[:hidden_announcement_ids]).first
    flash.now[:warning] = %Q{
                              <div class='announcement'>
                                <strong>
                                Breaking News: #{view_context.link_to(announcement.headline, announcements_path)}
                                (This message will disappear #{view_context.time_ago_in_words(announcement.expiry_date)} from now)
                                </strong>
                                #{view_context.link_to(hide_announcement_path(announcement), class: 'hide-breaking-news', remote: true) {  view_context.fa_icon 'remove', text: 'hide' }}
                              </div>
                            }.html_safe if announcement.present?

  end

  def confirm_subscription!
    redirect_to new_order_url if current_user.subscription.expired?
  end

  def with_timezone(&block)
    timezone = current_user.try(:time_zone) || 'UTC'
    Time.use_zone(timezone, &block)
  end
end
