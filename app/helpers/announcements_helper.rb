module AnnouncementsHelper
  def latest_announcements
    Announcement.where('created_at >= ?', 7.days.ago)
  end

  def latest_announcement
    latest_announcements.first
  end
end
