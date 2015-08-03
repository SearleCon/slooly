# == Schema Information
#
# Table name: vouchers
#
#  id             :integer          not null, primary key
#  unique_code    :string(255)
#  redeemed_by    :integer
#  valid_until    :datetime
#  number_of_days :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Voucher < ActiveRecord::Base
  attr_readonly :unique_code, :valid_until, :number_of_days

  belongs_to :redeemer, class_name: 'User', foreign_key: :redeemed_by

  validate :expired?, :redeemed?, on: :update

  after_initialize :set_defaults, if: :new_record?

  before_create :generate_code

  before_update :extend_redeemer_subscription

  def redeemed?
    errors.add(:redeemed_by, 'is not blank') if redeemed_by_changed? && redeemed_by_was.present?
  end

  def expired?
    errors.add(:valid_until, 'date has already passed.') if  valid_until.past?
  end

  private

  def set_defaults
    self.valid_until = 1.month.from_now
    self.number_of_days = 30
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
