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

require 'spec_helper'

describe Suggestion do
  pending "add some examples to (or delete) #{__FILE__}"
end
