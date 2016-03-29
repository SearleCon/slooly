module Clients
  class InvoicesController < ApplicationController
    before_action :set_client

    def new
      @invoice = @client.invoices.build
    end

    def create
      @invoice = @client.invoices.create(invoice_params)
      respond_with([@client, @invoice], location: client_url(@client))
    end

    def destroy
      @invoice = @client.invoices.find(params[:id])
      @invoice.destroy
      respond_with([@client, @invoice], location: -> { request.referrer })
    end

    private

    def interpolation_options
      { resource_name: @invoice.invoice_number }
    end

    def set_client
      @client = Client.find(params[:client_id])
    end

    def invoice_params
      params.fetch(:invoice).permit(:amount, :description, :due_date, :invoice_number, :status, :last_date_sent).merge(user_id: current_user.id)
    end
  end
end
