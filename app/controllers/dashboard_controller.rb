class DashboardController < ApplicationController
  decorates_assigned :clients

  def index
    @clients = current_user.clients.includes(:invoices_chasing).joins(:invoices).merge(Invoice.chasing).distinct.order(updated_at: :desc).page(params[:page])
  end
end
