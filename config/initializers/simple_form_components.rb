module SimpleForm
  module Inputs
    class FileInput < Base
      def input
        idf = "#{lookup_model_names.join("_")}_#{reflection_or_attribute_name}"
        input_html_options[:style] ||= 'display:none;'

        button = template.content_tag(:div, class: 'input-append') do
          template.tag(:input, id: "pbox_#{idf}", class: 'string input-medium', type: 'text') +
              template.content_tag(:a, "Browse", class: 'btn btn-inverse', onclick: "$('input[id=#{idf}]').click();")
        end

        script = template.content_tag(:script, type: 'text/javascript') do
          "$('input[id=#{idf}]').change(function() { s = $(this)[0].files[0].name; $('#pbox_#{idf}').val(s); });".html_safe
        end

        @builder.file_field(attribute_name, input_html_options) + button + script
      end
    end
  end
end