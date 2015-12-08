class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  delegate :content_tag, :capture, :concat, to: :@template

  [:text_field, :text_area, :email_field, :password_field, :telephone_field, :number_field].each do |name|
    define_method(name) do |attribute, opts = {}|
      control_group(attribute) do
        concat(control_label(attribute, opts.delete(:label)))
        concat(controls { super(attribute, opts) })
      end
    end
  end

  def select(attribute, choices = nil, options = {}, html_options = {})
    control_group(attribute) do
      concat(control_label(attribute, options.delete(:label)))
      concat(controls { super(attribute, choices, options, html_options) })
    end
  end

  def collection_select(attribute, collection, value_method, text_method, options = {}, html_options = {})
    control_group(attribute) do
      concat(control_label(attribute, options.delete(:label)))
      concat(controls { super(attribute, collection, value_method, text_method, options, html_options) })
    end
  end

  def date_picker(attribute, options = {})
    options[:data] = options.fetch(:data, {}).merge(behaviour: 'datepicker')
    value = options[:value]
    value ||= object.send(attribute) if object.respond_to? attribute
    options[:value] = value.to_date.strftime('%dd/%B/%YYYY') if value.present?
    control_group(attribute) do
      concat(control_label(attribute, options.delete(:label)))
      concat(controls { ActionView::Helpers::FormBuilder.instance_method(:text_field).bind(self).call(attribute, options) })
    end
  end

  def time_zone_select(attribute, priority_zones = nil, options = {}, html_options = {})
    control_group(attribute) do
      concat(control_label(attribute, options.delete(:label)))
      concat(controls { super(attribute, priority_zones, options, html_options) })
    end
  end

  def check_box(attribute, options = {}, checked_value = '1', unchecked_value = '0')
    label_text = options.delete(:label) || attribute.to_s.humanize
    control_group(attribute) do
      concat(label(attribute, class: :checkbox) do
        concat(super(attribute, options, checked_value, unchecked_value))
        concat(label_text)
      end)
    end
  end

  def submit(value = nil, options = {})
    options[:class] = 'btn btn-primary' unless options.key?(:class)
    super(value, options)
  end

  private

  def control_group(attribute)
    classes = %w(control-group)
    classes << 'error' if object.errors[attribute].any?
    content_tag :div, class: classes do
      yield
      concat(content_tag :span, object.errors[attribute].join(', '), class: 'help-block') if object.errors[attribute].any?
    end
  end

  def control_label(attribute, text = nil)
    content_tag :div, label(attribute, text), class: 'control-label'
  end

  def controls
    content_tag :div, class: 'controls' do
      yield
    end
  end
end
