module AttributeNormalizer
  extend ActiveSupport::Concern

  included do
    before_validation :normalize_attributes
  end

  private

  def normalize_attributes
    normalize_string_attributes
    normalize_text_attributes
  end

  def normalize_string_attributes
    attributes_for(:string).each { |name| self[name] = self[name].blank? ? nil : self[name].squish }
  end

  def normalize_text_attributes
    attributes_for(:text).each { |name| self[name] = self[name].blank? ? nil : self[name].strip.squeeze(' ') }
  end

  def attributes_for(type)
    self.class.columns.select { |column| column.type == type }.map(&:name)
  end
end
