class SessionsController < Devise::SessionsController
  skip_before_action :authenticate_user!

  def create
    super do |user|
      if user.subscription.expired?
        redirect_to new_order_url and return
      else
        flash[:info] = t('flash.subscriptions.status', period: view_context.time_ago_in_words(user.subscription.expiry_date))
      end
    end
  end

  protected

  def after_sign_in_path_for(_resource)
    root_url
  end

  def after_sign_out_path_for(_resource)
    new_suggestion_url
  end
end
