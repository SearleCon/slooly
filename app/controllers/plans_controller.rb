class PlansController < ApplicationController
  before_action :authorize, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_plan, except: [:new, :create, :index]
  before_action :build_plan, only: [:new, :create]

  def index
    @plans = Plan.all
  end

  def create
    flash[:notice] = 'Plan was successfully created.' if @plan.save
    respond_with @plan
  end

  def update
    flash[:notice] = 'Plan was successfully updated.' if  @plan.update(plan_params)
    respond_with @plan
  end

  def destroy
    @plan.destroy
    respond_with @plan
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

  def authorize
    redirect_to root_url, alert: 'You are not authorized to perform this action' unless current_user.admin?
  end
end
