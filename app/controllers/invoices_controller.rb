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
    @invoice = current_user.invoices.build
  end

  def edit; end

  def create
    @invoice = current_user.invoices.build(invoice_params)
    setup_invoice_dates
    flash[:notice] = 'Invoice was successfully created.' if @invoice.save
    respond_with @invoice
  end

  def update
    @invoice.assign_attributes(invoice_params)
    setup_invoice_dates if @invoice.due_date_changed?
    flash[:notice] = 'Invoice was successfully updated.' if @invoice.save
    respond_with(@invoice)
  end

  def destroy
    @invoice.destroy
    respond_with(@invoice)
  end

  private

  def set_invoice
    @invoice = current_user.invoices.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(:amount, :client_id, :description, :due_date, :invoice_number, :status_id, :last_date_sent)
  end

  def invoice_dates
    InvoiceDates.new(@invoice, current_user.setting)
  end

  def setup_invoice_dates
    @invoice.pd_date = invoice_dates.pre_due
    @invoice.od1_date = invoice_dates.over_due1
    @invoice.od2_date = invoice_dates.over_due2
    @invoice.od3_date = invoice_dates.over_due3
    @invoice.last_date_sent = invoice_dates.last_date_sent
    @invoice.fd_date = invoice_dates.final_demand if @invoice.status == :send_final_demand
  end
end
