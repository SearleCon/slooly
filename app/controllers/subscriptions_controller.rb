class SubscriptionsController < ApplicationController
  before_action :set_plan, only: [:new, :paypal_checkout]

  def payment_plans
    @plans = Plan.active
  end

  def paypal_checkout
    subscription = current_user.subscriptions.build(plan_id: @plan.id)
    redirect_to subscription.paypal.checkout_url(return_url: new_subscription_url(plan_id: plan.id), cancel_url: root_url, ipn_url: payment_notifications_url)
  end

  def new
    @subscription = current_user.subscriptions.build(plan_id: @plan.id,
                                                     bought_on: Time.zone.now,
                                                     expiry_date: Time.zone.now.advance(months: @plan.duration),
                                                     time: "#{@plan.duration} month(s)")
    if params[:PayerID]
      @subscription.paypal_customer_token = params[:PayerID]
      @subscription.paypal_payment_token = params[:token]
    end
  end

  def create
    @subscription = current_user.subscriptions.build(subscription_params)
    if @subscription.save_with_paypal_payment
      flash[:notice] = 'Thank you for supporting us!'
    else
      flash.now[:alert] = 'There has been a problem activating your subscription. Please contact support.'
      render :new
    end
  end

  private

  def set_plan
    @plan = Plan.find(params[:plan_id])
  end

  def subscription_params
    params.require(:subscription).permit(:active,
                                         :bought_on,
                                         :expiry_date,
                                         :paypal_id,
                                         :plan_id,
                                         :time,
                                         :paypal_customer_token, :paypal_payment_token
    )
  end
end
