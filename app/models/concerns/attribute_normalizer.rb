module AttributeNormalizer
  extend ActiveSupport::Concern

  included do
    before_validation :normalize_attributes, prepend: true
  end

  private

  def normalize_attributes
    self.class.columns.select { |column| [:text, :string].include?(column.type) }.map(&:name).each do |attribute|
      self[attribute] = self[attribute].presence.try(:strip).try(:squeeze, ' ')
    end
  end
end
