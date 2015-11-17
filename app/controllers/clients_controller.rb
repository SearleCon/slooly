class ClientsController < ApplicationController


  before_action :authenticate_user!
  before_action :confirm_subscription!
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  def index
    @clients = current_user.clients.page(params[:page])
    @clients = Client.limit(40).page(params[:page])

    if @clients.empty?
      render :dashboard
    else
      fresh_when @clients
    end
  end

  def search
    @clients = current_user.clients.search(params[:q]).page(params[:page])
    flash[:info] = t('flash.clients.search', resource_name: view_context.pluralize(@clients.total_entries, 'client'), keywords: params[:q]) if params[:q]
    render :index
  end

  def show
    fresh_when @client
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    flash[:notice] = t('flash.clients.create', resource_name: @client.business_name) if @client.save
    respond_with @client
  end

  def update
    flash[:notice] = t('flash.clients.update', resource_name: @client.business_name) if @client.update(client_params)
    respond_with @client
  end

  def destroy
    @client.destroy
    respond_with(@client)
  end

  def exists
    respond_with { |format| format.json { render json: !current_user.clients.where("lower(business_name) = ?", client_params[:business_name].downcase).exists? } }
  end

  private
  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:address, :business_name, :city, :contact_person, :email, :fax, :post_code, :telephone).merge(user: current_user)
  end
end
