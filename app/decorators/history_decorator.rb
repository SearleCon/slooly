class HistoryDecorator < Decorators::BaseDecorator
BADGES_FOR_REMINDER_TYPES = { Pre: 'badge badge-success',
                                Due: 'badge badge-info',
                                OD1: 'badge badge-inverse',
                                OD2: 'badge badge-warning',
                                OD3: 'badge badge-important',
                                FD: 'badge' }.with_indifferent_access

  def date_sent
    h.local_time_ago(model.date_sent)
  end

  def reminder_badge
    h.content_tag :span, reminder_type, class: BADGES_FOR_REMINDER_TYPES[reminder_type]
  end

  def short_subject
    h.truncate(subject, length: 50)
  end

  def short_message
    h.truncate(history.message, length: 70)
  end

  def message
    h.simple_format(model.message)
  end
end
