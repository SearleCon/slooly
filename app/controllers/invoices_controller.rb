class InvoicesController < ApplicationController

  before_action :authenticate_user!, :authorize_user!
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  def index
    if params[:q]
      @invoices = current_user.invoices.includes(:client).search(params[:q]).limit(30).page(params[:page])
      flash.now[:info] = "#{view_context.pluralize(@invoices.total_count, 'result')} found."
    else
      @invoices = current_user.invoices.includes(:client).page(params[:page])
    end
  end

  def show
    fresh_when @invoice
  end

  def new
    @invoice = Invoice.new
  end

  def create
    @invoice = Invoice.create(invoice_params)
    respond_with @invoice
  end

  def update
    @invoice.update(invoice_params)
    respond_with(@invoice)
  end

  def destroy
    @invoice.destroy
    respond_with(@invoice, location: -> { request.referer })
  end

  private

  def interpolation_options
    { resource_name: @invoice.invoice_number }
  end

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(:amount, :client_id, :description, :due_date, :invoice_number, :status, :last_date_sent).merge(user_id: current_user.id)
  end
end
