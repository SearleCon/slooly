class DashboardController < ApplicationController

  before_action :authenticate_user!, :authorize_user!

  def index
    @clients = current_user.clients.joins(:outstanding_invoices).distinct.order(updated_at: :desc).page(params[:page])
    fresh_when @clients
  end
end
