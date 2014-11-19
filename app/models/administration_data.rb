class AdministrationData
  def initialize(users, new_users, histories, suggestions, jobs)
    @users = users
    @new_users = new_users
    @histories = histories
    @suggestions = suggestions
    @jobs = jobs
  end

  def delayed_jobs
    @jobs
  end

  def new_users
    @new_users
  end

  def emails_sent_today_count
    @histories.where('created_at >= ?', DateTime.yesterday).size
  end

  def emails_sent_last_7_days_count
    @histories.where('created_at >= ?', seven_days_ago).size
  end

  def last_25_emails_sent
    @histories.limit(25)
  end

  def suggestions_last_7_days_count
    @suggestions.where('created_at >= ?', seven_days_ago).size
  end

  def total_suggestions
    @suggestions.size
  end

  def total_users
    @users.total_entries
  end

  def users
    @users
  end

  private

  def seven_days_ago
    DateTime.now - 7.days
  end
end
