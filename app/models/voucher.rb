# == Schema Information
#
# Table name: vouchers
#
#  id             :integer          not null, primary key
#  unique_code    :string(255)
#  redeemed_by    :integer
#  valid_until    :datetime
#  number_of_days :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Voucher < ActiveRecord::Base
  belongs_to :redeemer, class_name: 'User', foreign_key: :redeemed_by

  validates :number_of_days, :valid_until, presence: true, on: :create
  validate :expired?, :redeemed?, on: :update

  before_create :generate_code, :set_valid_until

  before_update :extend_redeemer_subscription

  def redeemed?
    errors.add(:redeemed_by, 'is not blank') if redeemed_by_changed? && redeemed_by_was.present?
  end

  def expired?
    errors.add(:valid_until, 'date has already passed.') if  valid_until.past?
  end

  private

  def set_valid_until
    self.valid_until = 1.month.from_now
  end

  def generate_code
    self.unique_code = CouponCode.generate
    generate_code unless CouponCode.validate(unique_code)
  end

  def extend_redeemer_subscription
    redeemer.subscription.expiry_date += number_of_days.days
    redeemer.subscription.save
  end
end
