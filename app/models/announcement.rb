class Announcement < ActiveRecord::Base
  attr_accessible :description, :headline, :posted_by
end
