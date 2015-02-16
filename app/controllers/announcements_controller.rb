class AnnouncementsController < ApplicationController
  skip_before_action :authenticate_user!

  decorates_assigned :announcements
  decorates_assigned :announcement

  def index
    @announcements = Announcement.recent
  end

  def show
    @announcement = Announcement.find(params[:id])
    fresh_when @announcement
  end
end
