module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t('errors.messages.not_saved',
      count: resource.errors.count,
      resource: resource.class.model_name.human.downcase)

    html = <<-HTML
        <div id="devise-errors" class="panel panel-danger">
          <div class="panel-heading">
            <button type="button" class="close" data-target="#devise-errors" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="panel-title">#{sentence}</h4>
          </div>
          <div class="panel-body">
            <ul class="list-unstyled">#{messages}</ul>
          </div>
       </div>
    HTML

    html.html_safe
  end
end
