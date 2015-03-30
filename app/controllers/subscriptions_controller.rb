class SubscriptionsController < ApplicationController
  skip_before_action :validate_subscription

  before_action :set_plan, only: [:new, :paypal_checkout]

  # def payment_plans
  #   @plans = Plan.active.where.not(free: true)
  # end
  #
  # def paypal_checkout
  #   subscription = current_user.subscriptions.build(plan_id: @plan.id)
  #   redirect_to subscription.paypal.checkout_url(return_url: new_subscription_url(plan_id: plan.id), cancel_url: root_url)
  # end

  def new
    if params[:PayerID]
      @subscription = current_user.subscriptions.build(plan_id: @plan.id)
      @subscription.paypal_customer_token = params[:PayerID]
      @subscription.paypal_payment_token = params[:token]
    else
      redirect_to new_order_url(@plan.id)
    end

  end

  def create
    @subscription = current_user.subscriptions.build(subscription_params)
    if @subscription.save_with_paypal_payment
      flash[:notice] = t('flash.subscriptions.activation.success')
    else
      flash.now[:alert] = t('flash.subscriptions.activation.failed')
      render :new
    end
  end

  private

  def set_plan
    @plan = Plan.find(params[:plan_id])
  end

  def subscription_params
    params.require(:subscription).permit(:plan_id, :paypal_customer_token, :paypal_payment_token)
  end
end
