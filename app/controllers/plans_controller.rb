class PlansController < ApplicationController
  before_action :authorize, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_plan, except: [:new, :create, :index]

  def index
    @plans = Plan.all
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.create(plan_params)
    flash[:notice] = 'Plan was successfully created.' if @plan.errors.empty?
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

  def plan_params
    params.require(:plan).permit(:active, :cost, :description, :duration)
  end

  def authorize
    redirect_to root_url, alert: 'You are not authorized to perform this action' unless current_user.has_role? :admin
  end
end
