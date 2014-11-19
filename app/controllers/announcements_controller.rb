class AnnouncementsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :authorize, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_announcement, only: [:show, :edit, :update, :destroy]

  def index
    @announcements = Announcement.order('created_at desc')
  end

  def new
    @announcement = Announcement.new
  end

  def create
    @announcement = Announcement.create(announcement_params)
    flash[:notice] = 'Announcement was successfully created.' if @announcement.errors.empty?
    respond_with @announcement
  end

  def update
    flash[:notice] = 'Announcement was successfully updated.' if @announcement.update(announcement_params)
    respond_with @announcement
  end

  def destroy
    @announcement.destroy
    respond_with @announcement
  end

  private

  def set_announcement
    @announcement = Announcement.find(params[:id])
  end

  def announcement_params
    params.require(:announcement).permit(:description, :headline, :posted_by)
  end

  def authorize
    redirect_to root_url, alert: 'You are not authorized to perform this action' unless current_user.has_role? :admin
  end
end
