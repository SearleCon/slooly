module Admins
  class Dashboard
    def delayed_jobs_count
      jobs.count
    end

    def new_users
      users.includes(subscription: :plan).where('created_at >= ?', DateTime.yesterday)
    end

    def emails_sent_today_count
      histories.where(date_sent: Date.current).count
    end

    def emails_sent_last_7_days_count
      histories.where('date_sent >= ?', 7.days.ago).count
    end

    def last_25_emails_sent
      histories.last(25)
    end

    def suggestions_last_7_days_count
      suggestions.where('created_at >= ?', 7.days.ago).count
    end

    def total_suggestions
      suggestions.count
    end

    def total_users
      users.count
    end

    private

    def jobs
      @jobs ||= Delayed::Job.all
    end

    def histories
      @histories ||= History.all
    end

    def users
      @users ||= User.all
    end

    def suggestions
      @suggestions ||= Suggestion.all
    end
  end
end
