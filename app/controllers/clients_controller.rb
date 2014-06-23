class ClientsController < ApplicationController
  before_filter :set_client, except: [:index, :new, :create]

  def index
    @q = current_user.clients.search(params[:q])
    @q.sorts = 'updated_at desc' if @q.sorts.empty?
    @clients = @q.result(distinct: true).page(params[:page])
  end

  def new
    @client = current_user.clients.build
  end

  def edit;end

  def show
    fresh_when @client
  end

  def create
    @client = current_user.clients.create(client_params)
    flash[:notice] =  'Client was successfully created.' if @client.errors.empty?
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

  # GET creates new import for clients
  def import_clients
    @import = Client.build_importer
  end

  # POST reads from the spreadsheets and saves
  def import
    @import = Client.build_importer(params[:importer])
    @import.imported.each { |record| record.user_id = current_user.id }
    if @import.save
      redirect_to clients_url
    else
      render 'import_clients'
    end
  end
  
  private
    def set_client
      @client = current_user.clients.includes(:invoices).find(params[:id])
    end

    def client_params
      params.require(:client).permit(:address, :business_name, :city, :contact_person, :email, :fax, :post_code, :telephone)
    end
end
