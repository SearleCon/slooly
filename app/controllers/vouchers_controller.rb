class VouchersController < ApplicationController
  before_action :authenticate_user!
  before_action :confirm_subscription!

  def redeem
    voucher = Voucher.find_by(unique_code: params[:unique_code])
    if voucher.present? && voucher.update(redeemer: current_user)
      flash[:notice] = 'Congratulations! Your voucher was successfully redeemed!'
    else
      flash[:alert] = 'This voucher is no longer valid or has already been redeemed'
    end
    redirect_to edit_user_registration_path
  end
end
