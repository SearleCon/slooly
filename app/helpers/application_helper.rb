module ApplicationHelper
  def boolean_to_words(value)
    value ? 'Yes' : 'No'
  end

  def strong(text)
    content_tag :strong, text
  end
end
