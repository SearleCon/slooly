class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  # GET /invoices
  # GET /invoices.json
  def index
    @q = current_user.invoices.search(params[:q])
    @q.sorts = 'updated_at desc' if @q.sorts.empty?
    @invoices = @q.result(distinct: true).page(params[:page])
  end

  def show
    fresh_when @invoice
  end

  def new
    @invoice = Invoice.new
  end

  def edit; end

  def create
    @invoice = current_user.invoices.build(invoice_params)
    flash[:notice] = 'Invoice was successfully created.' if @invoice.save
    respond_with @invoice
  end

  def update
    flash[:notice] = 'Invoice was successfully updated.' if @invoice.update(invoice_params)
    respond_with(@invoice)
  end

  def destroy
    @invoice.destroy
    respond_with(@invoice)
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def invoice_params
    params.fetch(:invoice, {}).permit(:amount, :client_id, :description, :due_date, :invoice_number, :status_id, :last_date_sent)
  end
end
