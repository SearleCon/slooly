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

class Announcement < ActiveRecord::Base
  include AttributeNormalizer

  EXPIRY_PERIOD = 7

  default_scope { order(created_at: :desc) }

  validates :headline, :description, :posted_by, presence: true

  scope :recent, -> { where('created_at >= ?', EXPIRY_PERIOD.days.ago) }
  scope :unread, ->(ids) { where.not(id: ids)}

  before_save do
    self.headline = headline.titleize
  end

  def expiry_date
    @expiry_date ||= created_at.days_since(EXPIRY_PERIOD)
  end
end
