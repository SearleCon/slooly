module AnnouncementsHelper
  def announcements
    Announcement.last_7_days
  end

  def latest_announcement
    announcements.first
  end

  def time_remaining_for_announcement
    ((latest_announcement.created_at.to_date + 7.days) - Date.today).to_i
  end
end
