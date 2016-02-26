class ReportsController < ApplicationController
  before_action :authenticate_user!, :authorize_user!

  def index
    invoices = current_user.invoices.includes(:client).chasing
    @per_client_summary = invoices.group_by(&:client).each_with_object({}) { |(key, value), hash| hash[key] = SummaryReport.new(value) }
    @overall_summary = SummaryReport.new(invoices)
  end
end
