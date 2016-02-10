# == Schema Information
#
# Table name: clients
#
#  id             :integer          not null, primary key
#  business_name  :string(255)
#  contact_person :string(255)
#  address        :string(255)
#  city           :string(255)
#  post_code      :string(255)
#  telephone      :string(255)
#  fax            :string(255)
#  email          :string(255)
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class ClientsController < ApplicationController
  before_action :authenticate_user!, :authorize_user!
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  def index
    @q = current_user.clients.ransack(params[:q])
    @q.sorts = 'business_name desc' if @q.sorts.empty?
    @clients = @q.result.page(params[:page])
  end

  def show
    fresh_when @client
  end

  def new
    @client = current_user.clients.new
  end

  def create
    @client = current_user.clients.create(client_params)
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
    params.require(:client).permit(:address, :business_name, :city, :contact_person, :email, :fax, :post_code, :telephone)
  end

  def interpolation_options
    { resource_name: @client.business_name }
  end
end
