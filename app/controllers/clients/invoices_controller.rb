class Clients::InvoicesController < ApplicationController
  before_action :set_client

  def new
    @invoice = @client.invoices.build
  end

  def create
    @invoice = @client.invoices.build(invoice_params)
    @invoice.user = current_user
    flash[:notice] = t('flash.clients.invoices.create', resource_name: @client.business_name) if @invoice.save
    respond_with([@client, @invoice], location: client_url(@client))
  end

  private

  def set_client
    @client = Client.find(params[:client_id])
  end


  def invoice_params
    params.fetch(:invoice, {}).permit(:amount, :description, :due_date, :invoice_number, :status, :last_date_sent)
  end
end
