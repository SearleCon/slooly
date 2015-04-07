class ClientsController < ApplicationController
  etag { current_user.try :id }

  before_action :set_client, only: [:show, :edit, :update, :destroy]
  before_action :build_client, only: [:new, :create]

  decorates_assigned :client
  decorates_assigned :clients

  def index
    if params[:q].present?
      @clients = client_scope.search(params[:q]).page(params[:page])
      flash[:info] = t('flash.clients.search', resource_name: view_context.pluralize(@clients.total_entries, 'client'), keywords: params[:q]) if params[:q]
    else
      @clients = client_scope.page(params[:page])
    end

    if stale?(etag: [@clients.cache_key, params[:q], params[:page]].compact)
      render (@clients.any? ? :index : :dashboard)
    end
  end

  def show
   fresh_when @client
  end

  def create
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
  def client_scope
    current_user.clients
  end

  def build_client
    @client = client_scope.new(client_params)
  end

  def set_client
    @client = client_scope.find(params[:id])
  end

  def client_params
    params.fetch(:client, {}).permit(:address, :business_name, :city, :contact_person, :email, :fax, :post_code, :telephone)
  end
end
