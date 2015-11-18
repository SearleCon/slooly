# == Schema Information
#
# Table name: subscriptions
#
#  id                             :integer          not null, primary key
#  plan_id                        :integer
#  expiry_date                    :date
#  active                         :boolean
#  user_id                        :integer
#  created_at                     :datetime
#  updated_at                     :datetime
#  paypal_customer_token          :string(255)
#  paypal_recurring_profile_token :string(255)
#

class Subscription < ActiveRecord::Base
  belongs_to :plan
  belongs_to :user, touch: true

  validates :plan, :user, presence: true

  scope :active, -> { where(active: true) }

  delegate :description, :duration, :cost, to: :plan, prefix: true


  before_create :set_expiry_date
  after_find :deactivate, if: :expired?

  def expired?
    expiry_date.past?
  end

  private
  def deactivate
    update(active: false)
  end

  def set_expiry_date
    self.expiry_date = plan_duration.months.from_now
  end

end
