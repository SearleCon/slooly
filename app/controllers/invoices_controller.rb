class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  decorates_assigned :invoice
  decorates_assigned :invoices

  def index
    @invoices = invoice_scope.page(params[:page])
    if @invoices.any?
      # fresh_when etag: [@invoices, params[:page]], last_modified: @invoices.maximum(:updated_at)
    else
      render :dashboard
    end
  end

  def search
    @invoices = invoice_scope.search(invoice_number_or_description_cont: params[:q][:keyword]).result.page(params[:page])
    flash[:info] = "#{view_context.pluralize(@invoices.size, 'invoice')} found containing the search string '#{params[:q][:keyword]}' (In their Invoice Number or Description fields)."
    if @invoices.blank? || @invoices.many?
      render :index
    else
      redirect_to @invoices.take
    end
  end

  def show
    fresh_when @invoice
  end

  def new
    @invoice = invoice_scope.new
  end

  def edit; end

  def create
    @invoice = invoice_scope.build(invoice_params)
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

  def invoice_scope
    current_user.invoices.includes(:client)
  end

  def set_invoice
    @invoice = invoice_scope.find(params[:id])
  end

  def invoice_params
    params.fetch(:invoice, {}).permit(:amount, :client_id, :description, :due_date, :invoice_number, :status_id, :last_date_sent)
  end
end
