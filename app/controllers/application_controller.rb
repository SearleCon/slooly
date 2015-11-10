class ApplicationController < ActionController::Base
  respond_to :html, :js, :json

  protect_from_forgery

  layout proc { false if request.xhr? }

  before_action :authenticate_user!
  before_action :set_announcement

  around_action :with_timezone, if: :user_signed_in?


  etag { [current_user.try(:id), flash] }


  def http_cache_forever(public: false, version: 'v1')
         expires_in 100.years, public: public
         yield if stale?(etag: "#{version}-#{request.fullpath}-#{flash.to_a.join(',')}", last_modified: Time.parse('2011-01-01').utc, public: public)
  end

  private
  def set_announcement
    announcement = Announcement.recent.where.not(id: cookies.signed[:hidden_announcement_ids]).first
    flash[:warning] = render_to_string(partial: 'layouts/breaking_news', locals: {announcement: announcement}) if announcement
  end

  def with_timezone
    timezone = current_user.time_zone || Time.find_zone(cookies[:timezone])
    Time.use_zone(timezone) { yield }
  end
end
