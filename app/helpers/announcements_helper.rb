module AnnouncementsHelper
  def announcements
    Announcement.where('created_at >= ?', 7.days.ago)
  end

  def latest_announcement
    announcements.first
  end
end
