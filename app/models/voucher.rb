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

  def redeemed?
    redeemed_by.present?
  end

  def expired?
    valid_until < Date.current
  end

  def redeem(redeemer)
    return false if redeemed? || expired?

    redeemed = false
    transaction do
      self.redeemer = redeemer
      redeemed = redeemer.subscription.extend_by(number_of_days) && save
      fail ActiveRecord::Rollback unless redeemed
    end
    redeemed
  end
end
