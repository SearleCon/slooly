class PagesController < ApplicationController
  skip_before_action :authenticate_user!, except: [:reports, :tutorial]

  def reports
    @summary_report = SummaryReport.new(current_user.invoices.chasing)
  end

  def about
    http_cache_forever(public: true) do
      render
    end
  end

  def privacy
    http_cache_forever(public: true) do
      render
    end
  end

  def tos
    http_cache_forever(public: true) do
      render
    end
  end

  def pricing
    http_cache_forever(public: true) do
      render
    end
  end

  def faq
    http_cache_forever(public: true) do
      render
    end
  end

  def tutorial
    http_cache_forever(public: true) do
      render
    end
  end
end
