module HistoriesHelper
  BADGES_FOR_REMINDER_TYPES = { Pre: 'badge badge-success',
                                Due: 'badge badge-info',
                                OD1: 'badge badge-inverse',
                                OD2: 'badge badge-warning',
                                OD3: 'badge badge-important',
                                FD: 'badge'}.with_indifferent_access

  def display_reminder_badge(history)
    content_tag :span, history.reminder_type, class: BADGES_FOR_REMINDER_TYPES[history.reminder_type]
  end
end
