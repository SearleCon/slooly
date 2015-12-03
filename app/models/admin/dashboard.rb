module Admin
  class Dashboard

    def delayed_jobs_count
      @delayed_jobs_count ||= Delayed::Job.count
    end

    def new_users
      @new_users || User.includes(subscription: :plan).where('created_at >= ?', DateTime.yesterday)
    end

    def emails_sent_today_count
      @emails_sent_today_count ||= History.where(date_sent: Date.current).count
    end

    def emails_sent_last_7_days_count
      @emails_sent_last_7_days_count ||= History.where('date_sent >= ?', 7.days.ago).count
    end

    def last_25_emails_sent
      @last_25_emails_sent ||= History.last(25)
    end

    def suggestions_last_7_days_count
      @suggestions_last_7_days_count ||= Suggestion.where('created_at >= ?', 7.days.ago).count
    end

    def total_suggestions
      @total_suggestions ||= Suggestion.count
    end

    def total_users
      @total_users ||= User.count
    end
  end
end
