class ReportsController < ApplicationController
  before_action :authenticate_user!, :authorize_user!

  def index
    invoices = current_user.invoices.includes(:client).chasing
    @per_client_summary = invoices.group_by(&:client).transform_values { |values| SummaryReport.new(invoices) }
    @overall_summary = SummaryReport.new(invoices)
  end
end
