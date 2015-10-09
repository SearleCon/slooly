class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  decorates_assigned :invoice
  decorates_assigned :invoices

  def index
    @invoices = current_user.invoices.includes(:client).page(params[:page])

    if @invoices.empty?
      render :dashboard
    else
      fresh_when @invoices
    end
  end

  def search
    @invoices = current_user.invoices.includes(:client).search(params[:q]).page(params[:page])
    flash[:info] = t('flash.invoices.search', resource_name: view_context.pluralize(@invoices.total_entries, 'invoice'), keywords: params[:q])
    render :index
  end

  def show
    fresh_when @invoice
  end

  def new
    @invoice = Invoice.new
  end

  def create
    @invoice = Invoice.new(invoice_params)
    flash[:notice] = t('flash.invoices.create', resource_name: @invoice.invoice_number) if @invoice.save
    respond_with @invoice
  end

  def update
    flash[:notice] = t('flash.invoices.update', resource_name: @invoice.invoice_number) if @invoice.update(invoice_params)
    respond_with(@invoice)
  end

  def destroy
    @invoice.destroy
    respond_with(@invoice)
  end

  private
  def set_invoice
    @invoice = invoice_scope.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(:amount, :client_id, :description, :due_date, :invoice_number, :status, :last_date_sent).merge(user: current_user)
  end
end
