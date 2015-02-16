class PlansController < ApplicationController
  before_action :authorize, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_plan, except: [:new, :create, :index]
  before_action :build_plan, only: [:new, :create]

  def index
    @plans = Plan.all
  end

  def create
    flash[:notice] = t("flash.actions.create", resource_name: @plan.description.titleize) if @plan.save
    respond_with @plan, location: plans_url
  end

  def update
    flash[:notice] = t("flash.plans.update", resource_name: @plan.description.titleize) if  @plan.update(plan_params)
    respond_with @plan, location: plans_url
  end

  def destroy
    @plan.destroy
    flash[:notice] = t("flash.plans.destroy", resource_name: @plan.description.titleize) if @plan.destroyed?
    respond_with @plan, location: plans_url
  end

  private
  def set_flash
    flash[:notice] = t("flash.actions.#{action_name}", resource_name: @plan.description.titleize)
  end

  def set_plan
    @plan = Plan.find(params[:id])
  end

  def build_plan
    @plan = Plan.new(plan_params)
  end

  def plan_params
    params.fetch(:plan, {}).permit(:active, :cost, :description, :duration)
  end

  def authorize
    redirect_to root_url, alert: 'You are not authorized to perform this action' unless current_user.admin?
  end
end
