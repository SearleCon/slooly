class ClientsController < ApplicationController
  etag { current_user.try :id }

  before_action :set_client, only: [:show, :edit, :update, :destroy]

  decorates_assigned :client
  decorates_assigned :clients

  def index
    @clients = client_scope.page(params[:page])
    if @clients.any?
      fresh_when etag: [@clients, params[:page]], last_modified: @clients.maximum(:updated_at) unless params[:q].present?
    else
      render :dashboard
    end
  end

  def search
    @clients = client_scope.search(business_name_or_contact_person_cont: params[:q][:keyword]).result.page(params[:page])
    flash[:info] = "#{view_context.pluralize(@clients.size, 'client')} found containing the search string '#{params[:q][:keyword]}' (In their Business Name or Contact Person fields)."
    if @clients.blank? || @clients.many?
      render :index
    else
      redirect_to @clients.take
    end
  end

  def new
    @client = client_scope.new
  end

  def show
    fresh_when @client
  end

  def create
    @client = client_scope.create(client_params)
    flash[:notice] =  'Client was successfully created.' unless @client.errors.any?
    respond_with @client
  end

  def update
    flash[:notice] = 'Client was successfully updated.' if @client.update(client_params)
    respond_with @client
  end

  def destroy
    @client.destroy
    respond_with @client
  end

  private

  def client_scope
    current_user.clients.includes(:histories, :invoices)
  end

  def set_client
    @client = client_scope.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:address, :business_name, :city, :contact_person, :email, :fax, :post_code, :telephone)
  end
end
