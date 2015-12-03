class ClientsController < ApplicationController

  before_action :authenticate_user!, :authorize_user!
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  def index
    if current_user.clients.any?
      @clients = current_user.clients.search(params[:q]).page(params[:page])
      fresh_when @clients
    else
      render :dashboard
    end
  end

  def show
    fresh_when @client
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.create(client_params)
    respond_with @client
  end

  def update
    @client.update(client_params)
    respond_with @client
  end

  def destroy
    @client.destroy
    respond_with(@client)
  end

  def exists
    respond_with { |format| format.json { render json: !current_user.clients.where('lower(business_name) = ?', client_params[:business_name].downcase).exists? } }
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:address, :business_name, :city, :contact_person, :email, :fax, :post_code, :telephone).merge(user_id: current_user.id)
  end

  def interpolation_options
    { resource_name: @client.business_name }
  end

end
