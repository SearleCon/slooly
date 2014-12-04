class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:about, :pricing, :faq, :tos, :privacy, :ie_warning]

  def home
    @clients = current_user.clients.joins(:invoices).merge(Invoice.chasing).distinct.order(:business_name).page(params[:page])
  end

  def reports
    @summary_report = SummaryReport.new(current_user.invoices.chasing)
  end
end
