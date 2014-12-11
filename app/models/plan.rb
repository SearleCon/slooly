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

class Plan < ActiveRecord::Base
  has_many :subscriptions

  scope :active, -> { where(active: true) }
end
