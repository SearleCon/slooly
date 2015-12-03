module Admins
  class PlansController < Admins::BaseController
    responders :collection

    before_action :set_plan, except: [:new, :create, :index]

    def index
      @plans = Plan.includes(:subscriptions).all
    end

    def new
      @plan = Plan.new
    end

    def create
      @plan = Plan.create(plan_params)
      respond_with :admins, @plan
    end

    def update
      @plan.update(plan_params)
      respond_with :admins, @plan
    end

    def destroy
      @plan.destroy
      respond_with :admins, @plan
    end

    private

    def interpolation_options
      { resource_name: @plan.description }
    end

    def set_plan
      @plan = Plan.find(params[:id])
    end

    def plan_params
      params.fetch(:plan).permit(:active, :cost, :description, :duration)
    end
  end
end
