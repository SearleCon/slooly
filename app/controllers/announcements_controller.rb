# == Schema Information
#
# Table name: announcements
#
#  id          :integer          not null, primary key
#  headline    :string(255)
#  description :text
#  posted_by   :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

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
