# == Schema Information
#
# Table name: vouchers
#
#  id             :integer          not null, primary key
#  unique_code    :string(255)
#  redeemed_by    :integer
#  valid_until    :datetime
#  number_of_days :integer          default(30)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class VouchersController < ApplicationController
  before_action :authenticate_user!, :authorize_user!

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
