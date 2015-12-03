module HttpCacheForever
  def http_cache_forever(public: false, version: 'v1')
    expires_in 100.years, public: public
    yield if stale?(etag: "#{version}-#{request.fullpath}-#{flash.to_a.join(',')}", last_modified: Time.parse('2011-01-01').utc, public: public)
  end
end
