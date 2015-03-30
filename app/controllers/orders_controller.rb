class OrdersController < ApplicationController
  skip_before_action :validate_subscription
  before_action :set_plan, except: :new


  def new
    @plans = Plan.available
  end

  def confirm
   redirect_to payment_order_path(@plan) unless params[:PayerID]
  end

  def payment;end

  def checkout
    response = paypal.checkout
    if response.success?
      redirect_to response.checkout_url
    else
      redirect_to payment_order_path(@plan), alert: 'There was a problem connecting to paypal, please try again.'
    end
  end

  def complete
    response = paypal.request_payment
    subscription = @plan.subscriptions.build(user: current_user, paypal_customer_token: params[:token], paypal_recurring_profile_token: params[:PayerID], active: true)
    if response.approved? && response.completed? && subscription.save
      flash[:notice] = t('flash.subscriptions.activation.success')
    else
      flash[:alert] = t('flash.subscriptions.activation.failed')
      render :confirm
    end
  end

  private
  def set_plan
    @plan = Plan.find(params[:id])
  end

  def paypal
    @paypal ||= PayPal::Recurring.new(return_url: confirm_order_url(@plan),
                                      cancel_url: root_url,
                                      token: params[:token],
                                      payer_id: params[:PayerID],
                                      description: @plan.description,
                                      amount: @plan.cost,
                                      currency: 'USD')
  end
end