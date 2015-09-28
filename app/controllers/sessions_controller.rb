class SessionsController < Devise::SessionsController
  skip_before_action :authenticate_user!, :validate_subscription

  def create
    super { |user|  flash[:info] =  t('flash.subscriptions.status', period: view_context.time_ago_in_words(user.subscription.expiry_date)) unless user.subscription.expired?  }
  end

  protected

  def after_sign_in_path_for(_resource)
    root_url
  end

  def after_sign_out_path_for(_resource)
    new_suggestion_url
  end
end
