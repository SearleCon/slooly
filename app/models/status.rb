# == Schema Information
#
# Table name: statuses
#
#  id          :integer          not null, primary key
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Status < ActiveRecord::Base
end
