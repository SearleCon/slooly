module HistoriesHelper
  BADGES_FOR_REMINDER_TYPES = { Pre: 'badge badge-success',
                                Due: 'badge badge-info',
                                OD1: 'badge badge-inverse',
                                OD2: 'badge badge-warning',
                                OD3: 'badge badge-important',
                                FD: 'badge' }.with_indifferent_access

  def reminder_badge(reminder_type)
    content_tag :span, reminder_type, class: BADGES_FOR_REMINDER_TYPES[reminder_type]
  end
end
