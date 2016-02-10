# == Schema Information
#
# Table name: invoices
#
#  id             :integer          not null, primary key
#  invoice_number :string(255)
#  due_date       :date
#  amount         :decimal(, )
#  description    :text
#  status         :integer          default(2)
#  client_id      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#  pd_date        :date
#  od1_date       :date
#  od2_date       :date
#  od3_date       :date
#  last_date_sent :date
#  fd_date        :date
#

class InvoicesController < ApplicationController
  before_action :authenticate_user!, :authorize_user!
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  def index
    @q = current_user.invoices.ransack(params[:q])
    @invoices = @q.result.includes(:client).page(params[:page])
  end

  def show
    fresh_when @invoice
  end

  def new
    @invoice = current_user.invoices.new
  end

  def create
    @invoice = current_user.invoices.create(invoice_params)
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
    params.require(:invoice).permit(:amount, :client_id, :description, :due_date, :invoice_number, :status, :last_date_sent)
  end
end
