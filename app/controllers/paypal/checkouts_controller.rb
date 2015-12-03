module Paypal
  class CheckoutsController < ApplicationController
    before_action :authenticate_user!

    def create
      plan = Plan.find(params[:plan_id])
      response = PayPal::Recurring.new(return_url: new_subscription_url(plan_id: plan.id),
                                       cancel_url: plans_url,
                                       description: plan.description,
                                       amount: plan.cost,
                                       currency: 'USD').checkout

      redirect_to response.checkout_url
    end
  end
  end
