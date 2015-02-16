class VouchersController < ApplicationController
  def redeem
    voucher = Voucher.find_by(unique_code: voucher_params[:unique_code])
    if voucher.present? && voucher.valid?
      voucher.redeem_for(current_user)
      redirect_to edit_user_registration_path, notice: t("flash.vouchers.actions.redeem.success")
    else
      redirect_to edit_user_registration_path, alert: t("flash.vouchers.actions.redeem.failed")
    end
  end

  private
  def voucher_params
    params.require(:voucher).permit(:unique_code)
  end
end
