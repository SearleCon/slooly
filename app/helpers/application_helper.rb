module ApplicationHelper
  def alert_class_for(type)
    { notice: 'alert alert-success',
      alert: 'alert alert-danger',
      info: 'alert alert-info',
      warning: 'alert alert-warning'
    }[type.to_sym]
  end
end
