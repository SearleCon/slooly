# == Schema Information
#
# Table name: suggestions
#
#  id         :integer          primary key
#  subject    :string(255)
#  comment    :text
#  email      :string(255)
#  created_at :timestamp        not null
#  updated_at :timestamp        not null
#

class Suggestion < ActiveRecord::Base
end
