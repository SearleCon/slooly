class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:about, :pricing, :faq, :tos, :privacy, :ie_warning]

  def home
    @q = current_user.invoices.chasing.search(params[:q])
    @q.sorts = 'updated_at desc' if @q.sorts.empty?
    @chasing_invoices = @q.result(distinct: true).includes(:client).page(params[:page])
  end

  def about
  end

  def faq
  end

  def pricing; end

  def tos; end

  def privacy; end

  def tutorial; end

  def reports
    @summary_report = SummaryReport.new(current_user.invoices.chasing)
  end
end
