class BaseDecorator < SimpleDelegator
  class << self
    alias_method :decorate, :new
  end

  def initialize(model, view_context)
    super(model)
    @h = view_context
  end

  def model
    @model ||= __getobj__
  end

  def class
    model.class
  end

  private
  attr_reader :h
end