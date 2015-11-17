class OrdersController < ApplicationController

  skip_before_action :authorize_user!

  before_action :authenticate_user!

  before_action :set_plan, except: :new

  def new
    @plans = Plan.available
  end

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
    if response.approved? && response.completed?
      Subscription.transaction do
        current_user.subscription.update!(active: false)
        current_user.create_subscription!(plan: @plan, paypal_customer_token: params[:token], paypal_recurring_profile_token: params[:PayerID])
      end
      flash[:notice] = 'Thank you for supporting us!'
    else
      flash[:alert] = 'There has been a problem activating your subscription. Please contact support.'
      render :confirm
    end
  end

  private

  def set_plan
    @plan = Plan.find(params[:id])
  end

  def paypal
    @paypal ||= PayPal::Recurring.new(return_url: confirm_order_url(@plan),
                                      cancel_url: payment_order_url(@plan),
                                      token: params[:token],
                                      payer_id: params[:PayerID],
                                      description: @plan.description,
                                      amount: @plan.cost,
                                      currency: 'USD')
  end
end
