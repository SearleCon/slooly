class RedeemVoucher
  def initialize(user, voucher_code)
    @user = user
    @subscription = user.active_subscription
    @voucher = Voucher.find_by_unique_code(voucher_code)
  end

  def call
     return false unless valid?
     @voucher.redeemed_by = @user.id
     @subscription.expiry_date += @voucher.number_of_days.days
     result = nil
     Voucher.transaction do
       result = @voucher.save && @subscription.save
       raise ActiveRecord::Rollback unless result
     end
     result
  end

  private
   def valid?
     return false unless @voucher
     @voucher.valid_until >= Date.today && !@voucher.redeemed_by
   end
end

