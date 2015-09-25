class ApplicationController < ActionController::Base
  protect_from_forgery

  layout proc { false if request.xhr? }


  before_action :authenticate_user!
  before_action :validate_subscription, if: :user_signed_in?
  before_action :set_announcements

  around_action :with_timezone, if: :user_signed_in?


  etag { [current_user.try(:id), flash] }

  private
  def set_announcements
    recent_announcements = Announcement.recent.where.not(id: cookies.signed[:hidden_announcement_ids]).to_a
    if recent_announcements.any?
      flash[:warning] = []
      recent_announcements.each do |announcement|
        flash[:warning] << render_to_string(partial: 'layouts/breaking_news', locals: { announcement: announcement })
      end
    end
  end

  def validate_subscription
    redirect_to new_order_url unless current_user.subscribed?
  end

  def with_timezone
    timezone = current_user.time_zone || Time.find_zone(cookies[:timezone])
    Time.use_zone(timezone) { yield }
  end
end
