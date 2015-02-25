class DashboardController < ApplicationController
  decorates_assigned :clients

  def index
    @clients = current_user.clients.includes(:invoices).merge(Invoice.chasing).references(:invoices).distinct.order(updated_at: :desc).page(params[:page])
  end
end
