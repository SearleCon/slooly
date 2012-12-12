class VouchersController < ApplicationController
  def redeem
    respond_to do |format|
      if Voucher.redeemable?(params[:unique_code]) && Voucher.redeem(params[:unique_code], current_user.id)
        format.html { redirect_to edit_user_registration_path, notice: 'Congratulations! Your voucher was successfully redeemed!' }
      else
        format.html { redirect_to edit_user_registration_path, alert: 'Unable to redeem the voucher. Please make sure you typed it correctly, and it is still valid. If this error persists, please contact support.' }
      end
    end
    
  end
end