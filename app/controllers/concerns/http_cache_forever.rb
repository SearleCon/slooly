module HttpCacheForever
  def http_cache_forever(version: 'v1')
    expires_in 100.years, public: true
    yield if stale?(etag: "#{version}-#{request.fullpath}-#{flash.to_a.join(',')}", last_modified: Time.parse('2011-01-01').utc, public: true)
  end
end
