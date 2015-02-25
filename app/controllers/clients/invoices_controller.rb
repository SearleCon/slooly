class Clients::InvoicesController < ApplicationController
  before_action :set_client
  before_action :build_invoice

  def create
    @invoice = @client.invoices.build(invoice_params)
    @invoice.user = current_user
    flash[:notice] = t('flash.clients.invoices.create', resource_name: @client.business_name.titleize) if @invoice.save
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
    params.fetch(:invoice, {}).permit(:amount, :description, :due_date, :invoice_number, :status, :last_date_sent)
  end
end
