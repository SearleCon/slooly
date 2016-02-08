class SessionsController < Devise::SessionsController

  def create
    super do |user|
      flash[:info] = "Please note: Your subscription is coming to an end in #{view_context.time_ago_in_words(user.subscription.expiry_date)}. You do not have to do anything, as you will be prompted with options when logging in after the expiry date." if user.subscribed?
    end
  end

  protected

  def after_sign_out_path_for
    new_suggestion_url
  end
end
