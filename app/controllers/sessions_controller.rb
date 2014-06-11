class SessionsController < Devise::SessionsController
  skip_before_filter  :authenticate_user!
  skip_before_filter :subscription_required, only: :destroy

  protected
    def after_sign_in_path_for(resource)
        flash[:warning] = "Please note: Your subscription is coming to an end in #{current_user.active_subscription.expires_in} days. You do not have to do anything, as you will be prompted with options when logging in after the expiry date." if current_user.active_subscription.expires_in <= 3
        root_url
    end

    def after_sign_out_path_for(resource)
      new_suggestion_path
    end
end