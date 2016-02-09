require 'digest/md5'

module CoreExtensions
  module ActiveRecord
    module CollectionCacheKey
      def cache_key
        model_signature = model_name.cache_key
        if loaded?
          unique_signature = pluck(primary_key, :updated_at).flatten.join('-')
        else
          unique_signature = unscope(:order).pluck(primary_key, :updated_at).flatten.join('-')
        end
        "#{model_signature}/collection-digest-#{Digest::SHA256.hexdigest(unique_signature)}"
      end
    end
  end
end
