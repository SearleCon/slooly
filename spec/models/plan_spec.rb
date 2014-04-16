# == Schema Information
#
# Table name: plans
#
#  id          :integer          primary key
#  description :string(255)
#  duration    :integer
#  cost        :decimal(, )
#  active      :boolean
#  created_at  :timestamp        not null
#  updated_at  :timestamp        not null
#  free        :boolean
#

require 'spec_helper'

describe Plan do
  pending "add some examples to (or delete) #{__FILE__}"
end
