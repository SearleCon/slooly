class VouchersController < ApplicationController
  def redeem
    voucher = Voucher.find_by(unique_code: params[:unique_code])
    if voucher && voucher.update(redeemer: current_user)
      flash[:notice] = t('flash.vouchers.redeem.success')
    else
      flash[:alert] = t('flash.vouchers.redeem.failed')
    end
    redirect_to edit_user_registration_path
  end
end
