class ClientsController < ApplicationController
  etag { current_user.try :id }

  before_action :set_client, except: [:index, :import, :new, :create]

  def index
    @q = client_scope.search(params[:q])
    @q.sorts = 'updated_at desc' if @q.sorts.empty?
    @clients = @q.result(distinct: true).page(params[:page])
    fresh_when etag: [@clients, params[:page]], last_modified: @clients.maximum(:updated_at) unless params[:q].present?
  end

  def new
    @client = client_scope.new
  end

  def show
    #fresh_when @client
  end

  def create
    @client = client_scope.create(client_params)
    flash[:notice] =  'Client was successfully created.' if @client.errors.empty?
    respond_with @client
  end

  def import
    file_path = params[:file].path
    ext = File.extname(params[:file].original_filename).delete('.').to_sym
    ClientImporter.import(file_path, extension: ext, params: { user_id: current_user })
    redirect_to clients_url
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
