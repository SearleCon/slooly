class DashboardController < ApplicationController

  before_action :authenticate_user!
  before_action :confirm_subscription!

  decorates_assigned :clients

  def index
    @clients = current_user.clients.includes(:invoices).merge(Invoice.chasing).references(:invoices).distinct.order(updated_at: :desc).page(params[:page])
    fresh_when @clients
  end
end
