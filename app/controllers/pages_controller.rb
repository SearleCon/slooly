class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:about, :pricing, :faq, :tos, :privacy, :ie_warning]

  def home
    User.eager_load(:clients, :invoices).find(current_user.id)
  end

  def reports
    @summary_report = SummaryReport.new(current_user.invoices.chasing)
  end
end
