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

class Plan < ActiveRecord::Base
  has_many :subscriptions

  scope :active, -> { where(active: true) }
end
