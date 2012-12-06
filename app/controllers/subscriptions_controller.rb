class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :payment_made, :only => [:create]
  skip_before_filter :subscription_required 
  
# SHAUN Caches  
  # caches_action :payment_plans, :cache_path => proc {|c|
  #   plan = Plan.order('updated_at DESC').limit(1).first
  #   unless plan.nil?
  #     {:tag => plan.updated_at.to_i}
  #   end
  #   }
  
  def payment_plans
    @plans = Plan.find_all_by_active(true)
  end
  
  
  def paypal_checkout
      plan = Plan.find(params[:plan_id])
      subscription = plan.subscriptions.new
      subscription.user_id = current_user.id
      redirect_to subscription.paypal.checkout_url(
                      return_url: new_subscription_url(:plan_id => plan.id),
                      cancel_url: root_url, ipn_url: payment_notifications_url)
    end


  def new
      @plan = Plan.find(params[:plan_id])
      @subscription = @plan.subscriptions.build
      @subscription.user_id = current_user.id
      if params[:PayerID]
        @subscription.paypal_customer_token = params[:PayerID]
        @subscription.paypal_payment_token = params[:token]
        # @subscription.email = @subscription.paypal.checkout_details.email
      end
    end

  def create
      @subscription = Subscription.new(params[:subscription])
      @subscription.user_id = current_user.id
      if @subscription.save_with_paypal_payment
        redirect_to @subscription, :notice => "Thank you for supporting us!"
      else
        render :new
      end
    end
  
  
  
  
  # GET /subscriptions
  # GET /subscriptions.json
  def index
    @subscriptions = Subscription.all
  
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @subscriptions }
    end
  end
  
  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
    @subscription = Subscription.find(params[:id])
  
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subscription }
    end
  end
  
  # # GET /subscriptions/new
  # # GET /subscriptions/new.json
  # def new
  #   @subscription = Subscription.new
  # 
  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.json { render json: @subscription }
  #   end
  # end
  
  # GET /subscriptions/1/edit
  def edit
    @subscription = Subscription.find(params[:id])
  end
  
  # # POST /subscriptions
  # # POST /subscriptions.json
  # def create
  #   @subscription = Subscription.new(params[:subscription])
  # 
  #   respond_to do |format|
  #     if @subscription.save
  #       format.html { redirect_to @subscription, notice: 'Subscription was successfully created.' }
  #       format.json { render json: @subscription, status: :created, location: @subscription }
  #     else
  #       format.html { render action: "new" }
  #       format.json { render json: @subscription.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  
  # PUT /subscriptions/1
  # PUT /subscriptions/1.json
  def update
    @subscription = Subscription.find(params[:id])
  
    respond_to do |format|
      if @subscription.update_attributes(params[:subscription])
        format.html { redirect_to @subscription, notice: 'Subscription was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy
  
    respond_to do |format|
      format.html { redirect_to subscriptions_url }
      format.json { head :no_content }
    end
  end  
  
  private
    def payment_made
      if current_user.active_subscription.plan_id == params[:subscription][:plan_id].to_i
        flash[:notice] = "Your order has already been processed, and you have been redirected back home."
        redirect_to "/pages/home"
      end
    end
  
end
