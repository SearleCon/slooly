module Invoice::StatusExtension
  extend ActiveSupport::Concern

  STATUSES = { chasing: 2, stop_chasing: 3, paid: 4, send_final_demand: 5, write_off: 6, delete: 7 }.freeze

  STATUSES.each do |key, value|
    define_method "#{key}?" do
      status_id == value
    end
  end

  included do
    scope :chasing, -> { where(status_id: STATUSES[:chasing]) }
  end

  def status
    STATUSES.key(status_id)
  end
end
