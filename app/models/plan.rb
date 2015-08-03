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
  to_param :description

  has_many :subscriptions

  def self.free_trial
    Rails.cache.fetch('free_trial_plan', expires_in: 8.hours) do
      Plan.where(active: true, free: true).first
    end
  end

  def self.available
    Rails.cache.fetch('commercial_plans', expires_in: 8.hours) do
      Plan.where(active: true, free: false)
    end
  end
end
