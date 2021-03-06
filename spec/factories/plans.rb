# == Schema Information
#
# Table name: plans
#
#  id          :integer          not null, primary key
#  description :string(255)
#  duration    :integer
#  cost        :decimal(, )
#  active      :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  free        :boolean
#

FactoryGirl.define do
  factory :plan do
    description 'Plan'
    duration 1
    cost 0
    active false
    free false

    factory :free_trial do
      description 'Free Trial'
      duration 1
      cost 0
      active true
      free true
    end
  end
end
