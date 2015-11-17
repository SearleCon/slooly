class ReportsController < ApplicationController

  before_action :authenticate_user!, :authorize_user!

  def index
    @summary_report = SummaryReport.new(current_user.invoices.chasing)
  end
end
