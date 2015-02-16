class Admin::AnnouncementsController < Admin::BaseController
  before_action :set_announcement, only: [:show, :edit, :update, :destroy]
  before_action :build_announcement, only: [:new, :create]

  decorates_assigned :announcements
  decorates_assigned :announcement

  def index
    @announcements = Announcement.all
  end

  def create
    flash[:notice] = t('flash.announcements.create', resource_name: @announcement.headline.titleize) if @announcement.save
    respond_with @announcement, location: admin_announcements_url
  end

  def update
    flash[:notice] = t('flash.announcements.update', resource_name: @announcement.headline.titleize) if @announcement.update(announcement_params)
    respond_with @announcement, location: admin_announcements_url
  end

  def destroy
    @announcement.destroy
    flash[:notice] = t('flash.announcements.destroy', resource_name: @announcement.headline.titleize) if @announcement.destroyed?
    respond_with @announcement, location: admin_announcements_url
  end

  private
  def build_announcement
    @announcement = Announcement.new(announcement_params)
  end

  def set_announcement
    @announcement = Announcement.find(params[:id])
  end

  def announcement_params
    params.fetch(:announcement, {}).permit(:description, :headline, :posted_by)
  end
end
