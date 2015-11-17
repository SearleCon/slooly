module ApplicationHelper
  def alert_class_for(type)
    { notice: 'alert alert-success', alert: 'alert alert-error', info: 'alert alert-info', warning: 'alert' }[type.to_sym]
  end
end
