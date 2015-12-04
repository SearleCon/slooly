class AnnouncementsController < ApplicationController
  def index
    @announcements = Announcement.recent
  end

  def hide
    ids = [params[:id], *cookies.permanent.signed[:hidden_announcement_ids]]
    cookies.permanent.signed[:hidden_announcement_ids] = ids
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
end
