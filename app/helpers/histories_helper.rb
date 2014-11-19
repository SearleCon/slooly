module HistoriesHelper
  def display_reminder_badge(history)
    case history.reminder_type
      when 'Pre' then type = 'badge badge-success'
      when 'Due' then type = 'badge badge-info'
      when 'OD1' then type = 'badge badge-inverse'
      when 'OD2' then type = 'badge badge-warning'
      when 'OD3' then type = 'badge badge-important'
      else type = 'badge'
    end
    content_tag :span, history.reminder_type, class: type
  end
end
