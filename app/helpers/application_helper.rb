module ApplicationHelper
  def invalid_browser?
    browser.ie6? || browser.ie7? || browser.ie8?
  end

  def errors_for(model)
    if model && model.errors.any?
      content_tag(:div, class: 'error_explanation well well small') do
        concat (content_tag(:div, "#{pluralize(model.errors.count, 'error')} prevented this record from being saved:", class: 'alert alert-error'))
        concat (content_tag :ul, class: 'unstyled' do
                  model.errors.full_messages.map { |msg| content_tag(:li, msg) }.join.html_safe
                end)
      end
    end
  end

  def boolean_to_words(value)
    value ? 'Yes' : 'No'
  end

  def strong(text)
    content_tag :strong, text
  end
end
