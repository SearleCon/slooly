class SessionsController < Devise::SessionsController
  skip_before_action :authenticate_user!

  protected

  def after_sign_in_path_for(resource)
    if resource.user?
      if resource.active_subscription.has_expired?
        payment_plans_subscriptions_url
      else
        flash[:warning] = "Please note: Your subscription is coming to an end in #{current_user.active_subscription.expires_in} days. You do not have to do anything, as you will be prompted with options when logging in after the expiry date." if current_user.active_subscription.expires_in <= 3
      end
    end
    root_url
  end

  def after_sign_out_path_for(_resource)
    new_suggestion_url
  end
end
