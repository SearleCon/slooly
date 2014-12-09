class Clients::InvoicesController < ApplicationController
  before_action :set_client
  before_action :build_invoice

  def create
    @invoice = @client.invoices.build(invoice_params)
    @invoice.user = current_user
    flash[:notice] = "Invoice was successfully created for #{@client.business_name}." if @invoice.save
    respond_with @invoice, location: client_url(@client)
  end

  private

  def set_client
    @client = Client.find(params[:client_id])
  end

  def build_invoice
    @invoice = @client.invoices.build(invoice_params)
  end

  def invoice_params
    params.fetch(:invoice, {}).permit(:amount, :description, :due_date, :invoice_number, :status_id, :last_date_sent)
  end
end
