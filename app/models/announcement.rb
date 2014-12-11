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

  scope :last_7_days, -> { where(arel_table[:created_at].gteq(Date.today - 7.days)).order(created_at: :desc)  }
end
