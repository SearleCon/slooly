module Admins
  module Users
    class SubscriptionsController < Admins::BaseController
      before_action :set_user
      before_action :set_subscription

      def edit
      end

      def update
        @subscription.update(subscription_params)
        respond_with(:admins, @user, @subscription, location: admins_user_url(@user))
      end

      private

      def interpolation_options
        { resource_name: @user.name }
      end

      def set_user
        @user = User.find(params[:user_id])
      end

      def set_subscription
        @subscription = Subscription.find(@user.subscription.id)
      end

      def subscription_params
        params.require(:subscription).permit(:expiry_date)
      end
    end
  end
end
