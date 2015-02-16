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
  default_scope { order(created_at: :desc) }

  validates :headline, :description, :posted_by, presence: true

  def expiry_date
    @expiry_date ||= created_at.advance(days: 7)
  end
end
