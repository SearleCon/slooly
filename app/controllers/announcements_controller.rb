class AnnouncementsController < ApplicationController
  skip_before_action :authenticate_user!, :set_announcements

  decorates_assigned :announcements
  decorates_assigned :announcement

  def index
    @announcements = Announcement.recent
  end

  def hide
    ids = [params[:id], *cookies.signed[:hidden_announcement_ids]]
    cookies.permanent.signed[:hidden_announcement_ids] = ids
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { head :ok }
    end
  end
end
