class Admins::PlansController < Admins::BaseController
    before_action :set_plan, except: [:new, :create, :index]
    before_action :build_plan, only: [:new, :create]

    def index
      @plans = Plan.all
    end

    def create
      flash[:notice] = t("flash.actions.create", resource_name: @plan.description.titleize) if @plan.save
      respond_with @plan, location: admins_plans_url
    end

    def update
      flash[:notice] = t("flash.plans.update", resource_name: @plan.description.titleize) if  @plan.update(plan_params)
      respond_with @plan, location: admins_plans_url
    end

    def destroy
      @plan.destroy
      flash[:notice] = t("flash.plans.destroy", resource_name: @plan.description.titleize) if @plan.destroyed?
      respond_with @plan, location: admins_plans_url
    end

    private

    def set_plan
      @plan = Plan.find(params[:id])
    end

    def build_plan
      @plan = Plan.new(plan_params)
    end

    def plan_params
      params.fetch(:plan, {}).permit(:active, :cost, :description, :duration)
    end
end