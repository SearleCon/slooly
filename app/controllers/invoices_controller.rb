class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]
  before_action :build_invoice, only: [:new, :create]

  decorates_assigned :invoice
  decorates_assigned :invoices

  def index
    @invoices = invoice_scope.includes(:client).page(params[:page])
    if @invoices.any?
      fresh_when etag: [@invoices, params[:page]], last_modified: @invoices.maximum(:updated_at)
    else
      render :dashboard
    end
  end

  def search
    @invoices = invoice_scope.search(invoice_number_or_description_cont: params[:q][:keyword]).result.page(params[:page])
    flash.now[:info] = t("flash.invoices.search", resource_name: view_context.pluralize(@invoices.total_entries, 'invoice'), keywords: params[:q][:keyword] )
    respond_with @invoices
  end

  def show
    fresh_when @invoice
  end

  def create
    flash[:notice] = t("flash.invoices.create", resource_name: @invoice.invoice_number) if @invoice.save
    respond_with @invoice
  end

  def update
    flash[:notice] = t("flash.invoices.update", resource_name: @invoice.invoice_number) if @invoice.update(invoice_params)
    respond_with(@invoice)
  end

  def destroy
    @invoice.destroy
    respond_with(@invoice)
  end

  private
  def invoice_scope
    current_user.invoices
  end

  def build_invoice
    @invoice = invoice_scope.build(invoice_params)
  end

  def set_invoice
    @invoice = invoice_scope.find(params[:id])
  end

  def invoice_params
    params.fetch(:invoice, {}).permit(:amount, :client_id, :description, :due_date, :invoice_number, :status, :last_date_sent)
  end
end
