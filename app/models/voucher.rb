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
  attr_accessor :prefix, :suffix, :validity_period, :free_days

  belongs_to :redeemer, class_name: 'User', foreign_key: :redeemed_by

  before_create :generate_unique_code, :set_valid_until, :set_free_days

  validate :expired

  def redeem!(user)
    self.redeemer = user
    save!
  end

  private
  def expired
   if valid_until < Date.today || redeemer.present?
     errors.add(:expired, "has expired")
   end
  end

  def generate_unique_code
    self.unique_code = "#{prefix}#{SecureRandom.hex(4)}#{suffix}"
  end

  def set_valid_until
    period = validity_period || 0
    self.valid_until = Time.zone.now + period.months
  end

  def set_free_days
    self.number_of_days = free_days || 0
  end
end
