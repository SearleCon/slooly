class Admins::AnnouncementsController < Admins::BaseController
  responders :collection

  before_action :set_announcement, only: [:edit, :update, :destroy]

  def index
    @announcements = Announcement.all
  end

  def new
    @announcement = Announcement.new
  end

  def create
    @announcement = Announcement.create(announcement_params)
    respond_with(:admins, @announcement)
  end

  def update
    @announcement.update(announcement_params)
    respond_with(:admins, @announcement)
  end

  def destroy
    @announcement.destroy
    respond_with(:admins, @announcement)
  end

  private
  def interpolation_options
    { resource_name: @announcement.headline }
  end

  def set_announcement
    @announcement = Announcement.find(params[:id])
  end

  def announcement_params
    params.fetch(:announcement).permit(:description, :headline, :posted_by)
  end
end
