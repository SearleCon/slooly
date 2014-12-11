class ClientsController < ApplicationController
  etag { current_user.try :id }

  before_action :set_client, only: [:show, :edit, :update, :destroy]
  before_action :build_client, only: [:new, :create]

  decorates_assigned :client
  decorates_assigned :clients

  def index
    @clients = client_scope.page(params[:page])
    if @clients.any?
      fresh_when etag: [@clients, params[:page]], last_modified: @clients.maximum(:updated_at)
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

  def show
    # fresh_when @client
  end

  def create
    flash[:notice] = "#{@client.business_name.titleize} was successfully created." if  @client.save
    respond_with @client
  end

  def update
    flash[:notice] = "#{@client.business_name.titleize} was successfully updated." if @client.update(client_params)
    respond_with @client
  end

  def destroy
    @client.destroy
    flash[:notice] = "#{@client.business_name.titleize} was successfully destroyed." if @client.destroyed?
    respond_with(@client)
  end

  def exists
    respond_with do |format|
      format.json { render json: !current_user.clients.exists?(client_params) }
    end
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
