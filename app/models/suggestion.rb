# == Schema Information
#
# Table name: suggestions
#
#  id         :integer          not null, primary key
#  subject    :string(255)
#  comment    :text
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Suggestion < ActiveRecord::Base
end
