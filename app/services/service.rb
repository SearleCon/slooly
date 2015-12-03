module Service
  extend ActiveSupport::Concern

  module ClassMethods
    def perform(*args)
      new(*args).tap(&:perform)
    end
  end

  def perform
    fail NotImplementedError
  end

end
