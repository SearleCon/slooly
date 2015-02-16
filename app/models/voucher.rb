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

  validate :expired, :redeemed

  def redeem_for(user)
    Voucher.transaction do
      user.subscription.expiry_date += number_of_days
      user.subscription.save!
      update!(redeemed_by: user)
    end
  end

  private

  def expired
    errors.add(:expired, 'has expired.') if valid_until < Date.current
  end

  def redeemed
    errors.add(:redeemed, 'has already been redeemed.') if redeemer.present?
  end
end
