class BootstrapFormBuilder <  ActionView::Helpers::FormBuilder


def form_group(attribute, options={}, &block)
  options[:class] ||= ''
  options[:class] << ' form-group'
  options[:class] << ' has-error' if has_error?(attribute)
  @template.content_tag(:div, options, &block)
end

def errors_for(attribute)
  return if object.errors[attribute].empty?
  @template.content_tag :span, object.errors.full_messages_for(attribute).join(', '), class: 'help-block'
end

private

 def has_error?(attribute)
  object.errors[attribute].any?
 end

end
