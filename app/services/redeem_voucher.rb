class RedeemVoucher
  include Service

  def initialize(voucher, user)
    @voucher = voucher
    @user = user
  end

  def call
    Voucher.transaction do
      begin
        user.active_subscription.expiry_date += voucher.number_of_days
        user.active_subscription.save!
        voucher.update!(redeemed_by: user)
      rescue
        raise RedeemVoucherFailed
      end
    end
  end
end

class RedeemVoucherFailed < Exception; end
