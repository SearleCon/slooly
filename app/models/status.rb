# == Schema Information
#
# Table name: statuses
#
#  id          :integer          primary key
#  description :string(255)
#  created_at  :timestamp        not null
#  updated_at  :timestamp        not null
#

class Status < ActiveRecord::Base
  attr_accessible :description
end
