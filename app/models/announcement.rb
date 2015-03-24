# == Schema Information
#
# Table name: announcements
#
#  id          :integer          not null, primary key
#  headline    :string(255)
#  description :text
#  posted_by   :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Announcement < ActiveRecord::Base
  EXPIRY_PERIOD = 7

  default_scope { order(created_at: :desc) }

  validates :headline, :description, :posted_by, presence: true

  scope :recent, -> { where('created_at >= ?', EXPIRY_PERIOD.days.ago) }

  def expiry_date
    @expiry_date ||= created_at.days_since(EXPIRY_PERIOD)
  end
end
