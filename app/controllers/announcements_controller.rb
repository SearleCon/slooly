class AnnouncementsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :authorize, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_announcement, only: [:show, :edit, :update, :destroy]
  before_action :build_announcement, only: [:new, :create]

  decorates_assigned :announcements
  decorates_assigned :announcement

  def index
    @announcements = Announcement.all
  end

  def create
    flash[:notice] = t('flash.announcements.create', resource_name: @announcement.headline.titleize) if @announcement.save
    respond_with @announcement
  end

  def update
    flash[:notice] = t('flash.announcements.update', resource_name: @announcement.headline.titleize) if @announcement.update(announcement_params)
    respond_with @announcement
  end

  def destroy
    @announcement.destroy
    flash[:notice] = t('flash.announcements.destroy', resource_name: @announcement.headline.titleize) if @announcement.destroyed?
    respond_with @announcement
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

  def authorize
    redirect_to root_url, alert: t('flash.application.unauthorized') unless current_user.admin?
  end
end
