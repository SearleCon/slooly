# == Schema Information
#
# Table name: announcements
#
#  id          :integer          primary key
#  headline    :string(255)
#  description :text
#  posted_by   :string(255)
#  created_at  :timestamp        not null
#  updated_at  :timestamp        not null
#

class Announcement < ActiveRecord::Base
  attr_accessible :description, :headline, :posted_by
end
