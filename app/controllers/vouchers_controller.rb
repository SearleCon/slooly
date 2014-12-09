class VouchersController < ApplicationController
  def redeem
    voucher = Voucher.find_by(unique_code: params[:unique_code])
    if voucher.present? && voucher.valid?
      Vouchers::Redeem.call(voucher, current_user)
      redirect_to edit_user_registration_path, notice: 'Congratulations! Your voucher was successfully redeemed!'
    else
      redirect_to edit_user_registration_path, alert: 'This voucher is no longer valid or has already been redeemed'
    end
  rescue Vouchers::RedeemFailed
    redirect_to edit_user_registration_path, alert: 'Unable to redeem the voucher. Please make sure you typed it correctly, and it is still valid. If this error persists, please contact support.'
  end
end
