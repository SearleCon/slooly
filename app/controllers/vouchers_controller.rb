class VouchersController < ApplicationController
  def redeem
    voucher = Voucher.find_by(unique_code: params[:unique_code])
    if voucher.valid?
      Voucher.transaction do
        current_user.active_subscription.extend_by!(voucher.number_of_days)
        voucher.redeem!(current_user)
      end
      redirect_to edit_user_registration_path, notice: 'Congratulations! Your voucher was successfully redeemed!'
    else
      redirect_to edit_user_registration_path, alert: 'Unable to redeem the voucher. Please make sure you typed it correctly, and it is still valid. If this error persists, please contact support.'
    end
  end
end
