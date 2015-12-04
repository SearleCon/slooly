class AnnouncementsController < ApplicationController
  def index
    @announcements = Announcement.recent
  end

  def hide
    # ids = [params[:id], *cookies.permanent.signed[:hidden_announcement_ids]]
    cookies.permanent.signed[:hidden_announcement_ids] << [params[:id]]
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { head :ok }
    end
  end
end
