class VouchersController < ApplicationController
  def redeem
    respond_to do |format|
      if Voucher.redeemable?(params[:unique_code]) && Voucher.redeem(params[:unique_code], current_user.id)
        format.html { redirect_to edit_user_registration_path, notice: 'Voucher redeemed successfully' }
      else
        format.html { redirect_to edit_user_registration_path, alert: 'An error occured while trying to redeem your voucher. If this continues, please contact support.' }
      end
    end
    
  end
end