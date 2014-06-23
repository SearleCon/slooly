class SubscriptionsController < ApplicationController

  def payment_plans
    @plans = Plan.active
  end  
  
  def paypal_checkout
      plan = Plan.find(params[:plan_id])
      subscription = plan.subscriptions.new
      subscription.user_id = current_user.id
      redirect_to subscription.paypal.checkout_url(
                       return_url: new_subscription_url(plan_id: plan.id),
                      cancel_url: root_url, ipn_url: payment_notifications_url)
    end


  def new
      @plan = Plan.find(params[:plan_id])
      @subscription = current_user.subscriptions.build(plan_id: @plan.id)
      @subscription.expiry_date = Time.zone.now.advance(months: @plan.duration)
      @subscription.bought_on = Time.zone.now
      @subscription.time =  "#{@plan.duration} month(s)"
      if params[:PayerID]
        @subscription.paypal_customer_token = params[:PayerID]
        @subscription.paypal_payment_token = params[:token]
      end
    end

  def create
    @subscription = current_user.subscriptions.build(subscription_params)
    if @subscription.save_with_paypal_payment
      ActivateSubscription.new(current_user, @subscription).call
      flash[:notice] =  "Thank you for supporting us!"
    else
      render :new
    end
  end

  private
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
