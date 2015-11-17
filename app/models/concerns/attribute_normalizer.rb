module AttributeNormalizer
  extend ActiveSupport::Concern

  included do
    before_validation :normalize_attributes
  end

  private
  def normalize_attributes
    self.class.columns.select { |column| [:text, :string].include?(column.type) }.each do |column|
      value = read_attribute(column.name)
      if value.blank?
        write_attribute(column.name, nil)
      else
        write_attribute(column.name, ((column.type == :text) ? value.strip.squeeze(' ') : value.squish))
      end
    end
  end
end