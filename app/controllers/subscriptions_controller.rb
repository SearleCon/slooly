# == Schema Information
#
# Table name: subscriptions
#
#  id                             :integer          not null, primary key
#  plan_id                        :integer
#  expiry_date                    :date
#  active                         :boolean          default(TRUE)
#  user_id                        :integer
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  paypal_customer_token          :string(255)
#  paypal_recurring_profile_token :string(255)
#

class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @subscription = Subscription.new(plan_id: params[:plan_id], paypal_customer_token: params[:token], paypal_recurring_profile_token: params[:PayerID])
  end

  def create
    @subscription = Subscription.new(subscription_params)

    if SubscribeUser.perform(current_user, @subscription).success?
      flash.now[:notice] = 'Thank you for supporting us!'
    else
      flash.now[:alert] = 'There has been a problem activating your subscription. Please contact support.'
      render :new
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:plan_id, :paypal_recurring_profile_token, :paypal_customer_token).merge(user_id: current_user.id)
  end
end
