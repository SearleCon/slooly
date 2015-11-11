class ReportsController < ApplicationController

  before_action :authenticate_user!
  before_action :confirm_subscription!

  def index
    @summary_report = SummaryReport.new(current_user.invoices.chasing)
  end
end
