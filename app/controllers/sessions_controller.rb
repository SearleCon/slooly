class SessionsController < Devise::SessionsController
  skip_before_filter :subscription_required, only: :destroy

  protected
    def after_sign_in_path_for(resource)
        flash[:warning] = 'Please note: Your subscription is coming to an end in '+current_user.subscription_expiry.to_s+" days. You do not have to do anything, as you will be prompted with options when logging in after the expiry date." if (current_user.subscription_expiry <= 3)
        pages_home_path
    end

    def after_sign_out_path_for(resource)
      new_suggestion_path #SS This is for the logout redirect after Logout for the suggestion screen
    end
end