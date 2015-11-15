class CollectionDecorator
  include Enumerable

  class << self
    alias_method :decorate, :new
  end

  def initialize(collection, view_context)
    @collection = collection
    @h = view_context
  end

  def each(&block)
    collection.each { |item| yield "#{collection.klass}Decorator".constantize.decorate(item, @h) }
  end

  def method_missing(method_name, *args, &block)
    if collection.respond_to?(method_name)
      collection.send(method_name, *args, &block)
    else
      super
    end
  end

  def respond_to_missing?(method_name, include_private=false)
    collection.respond_to?(method_name, include_private)
  end

  private
  attr_reader :collection, :h
end