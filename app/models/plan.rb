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

class Plan < ActiveRecord::Base
  include AttributeNormalizer

  to_param :description

  has_many :subscriptions

  validates :description, :duration, :cost, presence: true

  scope :available, -> { where(active: true, free: false) }

  before_save do
    self.description = description.try(:titleize)
  end

  def self.free_trial
    find_by!(active: true, free: true)
  end
end
