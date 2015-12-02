module Service
  extend ActiveSupport::Concern

  module ClassMethods
    def perform(*args)
      new(*args).tap { |object| object.perform }
    end
  end

  def perform
    raise NotImplementedError
  end

end