# == Schema Information
#
# Table name: vouchers
#
#  id             :integer          primary key
#  unique_code    :string(255)
#  redeemed_by    :integer
#  valid_until    :timestamp
#  number_of_days :integer
#  created_at     :timestamp        not null
#  updated_at     :timestamp        not null
#

class Voucher < ActiveRecord::Base
  attr_readonly :unique_code, :valid_until, :number_of_days

  belongs_to :redeemer, class_name: 'User', foreign_key: :redeemed_by

  validate :expired, :redeemed

  private

  def expired
    errors.add(:expired, 'has expired.') if valid_until < Date.today
  end

  def redeemed
    errors.add(:redeemed, 'has already been redeemed.') if redeemer.present?
  end
end
