class ClientsController < ApplicationController


  before_action :authenticate_user!
  before_action :confirm_subscription!
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  def index
    @clients = decorate(current_user.clients.page(params[:page]))

    if @clients.empty?
      render :dashboard
    else
      fresh_when @clients
    end
  end

  def search
    @clients = decorate(current_user.clients.search(params[:q]).page(params[:page]))
    flash[:info] = t('flash.clients.search', resource_name: view_context.pluralize(@clients.total_entries, 'client'), keywords: params[:q]) if params[:q]
    render :index
  end

  def show
    @client = decorate(@client)
    fresh_when @client
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    flash[:notice] = t('flash.clients.create', resource_name: @client.business_name.titleize) if @client.save
    respond_with @client
  end

  def update
    flash[:notice] = t('flash.clients.update', resource_name: @client.business_name.titleize) if @client.update(client_params)
    respond_with @client
  end

  def destroy
    @client.destroy
    respond_with(@client)
  end

  def exists
    respond_with { |format| format.json { render json: !current_user.clients.exists?(client_params) } }
  end

  private
  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:address, :business_name, :city, :contact_person, :email, :fax, :post_code, :telephone).merge(user: current_user)
  end
end
