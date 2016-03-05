module CollectionCacheable
  extend ActiveSupport::Concern

  module ClassMethods
    def cache_key
      unique_signature = if current_scope.loaded?
                           pluck(collection.primary_key, :updated_at).flatten.join('-')
                         else
                           unscope(:order).pluck(primary_key, :updated_at).flatten.join('-')
                         end
      "#{model_name.cache_key}/collection-digest-#{Digest::SHA256.hexdigest(unique_signature)}"
    end
  end

end
