class AnnouncementsController < ApplicationController
  load_resource except: [:index]
  authorize_resource only: [:new, :create, :edit, :update, :destroy]

  def index
    @announcements = Announcement.order('created_at desc')
  end

  def show;end


  def new; end

  def edit;end


  def create
    flash[:notice] =  'Announcement was successfully created.' if @announcement.save
    respond_with @announcement
  end


  def update
    flash[:notice] =  'Announcement was successfully updated.' if @announcement.update_attributes(params[:announcement])
    respond_with @announcement
  end


  def destroy
    @announcement.destroy
    respond_with @announcement
  end
end
