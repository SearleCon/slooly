class PagesController < ApplicationController
  skip_before_action :authenticate_user!, except: [:home, :reports, :tutorial]

  def reports
    @summary_report = SummaryReport.new(current_user.invoices.chasing)
  end
end


