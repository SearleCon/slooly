class PagesController < ApplicationController
  skip_before_action :authenticate_user!, except: [:reports, :tutorial]

  def reports
    @summary_report = SummaryReport.new(current_user.invoices.chasing)
  end

  def about
    fresh_when(['about', flash], public: true)
  end

  def privacy
    fresh_when(['privacy', flash], public: true)
  end

  def tos
    fresh_when(['tos', flash], public: true)
  end

  def pricing
    fresh_when(['pricing', flash], public: true)
  end

  def faq
    fresh_when(['faq', flash], public: true)
  end

  def tutorial
    fresh_when(['tutorial', flash], public: true)
  end
end
