class ClientsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_client, except: [:index, :new, :create]
  helper_method :sort_column, :sort_direction
  
  def index
    @clients = current_user.clients.search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => 10)
  end

  def show;  end

  def new
    @client = current_user.clients.build
  end

  def edit;end

  def create
    @client = current_user.clients.build(params[:client])
    flash[:notice] =  'Client was successfully created.' if @client.save
    respond_with @client
  end

  def update
    flash[:notice] = 'Client was successfully updated.' if @client.update_attributes(params[:client])
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
    def sort_column
      Client.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
    end

    def set_client
      @client = current_user.clients.find(params[:id])
    end
end
