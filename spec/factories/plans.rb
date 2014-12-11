# == Schema Information
#
# Table name: plans
#
#  id          :integer          not null, primary key
#  description :string(255)
#  duration    :integer
#  cost        :decimal(, )
#  active      :boolean
#  created_at  :datetime
#  updated_at  :datetime
#  free        :boolean
#

FactoryGirl.define do
  factory :plan do
    description 'Plan'
    duration    1
    cost       0
    active     false
    free       false
  end
end
