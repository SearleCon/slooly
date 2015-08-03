class PagesController < ApplicationController
  skip_before_action :authenticate_user!, except: [:reports, :tutorial]

  etag { current_user.try :id }

  def reports
    @summary_report = SummaryReport.new(current_user.invoices.chasing)
  end

  def about
    fresh_when 'about', last_modified: 1.year.ago
  end

  def privacy
    fresh_when 'privacy', last_modified: 1.year.ago
  end

  def tos
    fresh_when 'terms_of_service', last_modified: 1.year.ago
  end

  def faq
    fresh_when 'faq', last_modified: 1.year.ago
  end

  def tutorial
    fresh_when 'tutorial', last_modified: 1.year.ago
  end
end
