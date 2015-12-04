class Job < Delayed::Job
  scope :failed, -> { where.not(last_error: nil) }
  scope :pending, -> { where(attempts: 0, locked_at: nil) }
  scope :working, -> { where.not(locked_at: nil) }
end
