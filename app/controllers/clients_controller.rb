class ClientsController < ApplicationController
  before_filter :authenticate_user!
  helper_method :sort_column, :sort_direction
  

  # GET /clients
  # GET /clients.json
  def index
#    @clients = Client.for_user(current_user.id)   
    @clients = Client.for_user(current_user.id).search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => 10)
        
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clients }
    end
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    @client = Client.for_user(current_user.id).find(params[:id]) 
    @client_invoices_chasing = Invoice.for_user_and_status(@client.id, 2)
    @client_invoices_history = History.for_client(@client.id).order("date_sent desc") # SS .order("date_sent desc") # SS - add .first(10) to only get the first 10 records - Decide if you want to do this

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @client }
    end
  end

  # GET /clients/new
  # GET /clients/new.json
  def new
    @client = Client.new 

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @client }
    end
  end

  # GET /clients/1/edit
  def edit
    @client = Client.for_user(current_user.id).find(params[:id])
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(params[:client])    
    @client.user_id = current_user.id   
    # 3.times { @client.invoices.build } # SS Creates 3 Invoices with the automatic foreign key of the Client
    

    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: 'Client was successfully created.' }
        format.json { render json: @client, status: :created, location: @client }
      else
        format.html { render action: "new" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /clients/1
  # PUT /clients/1.json
  def update
    @client = Client.for_user(current_user.id).find(params[:id])

    respond_to do |format|
      if @client.update_attributes(params[:client])
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client = Client.for_user(current_user.id).find(params[:id])
    @client.destroy

    respond_to do |format|
      format.html { redirect_to clients_url }
      format.json { head :no_content }
    end
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
end
