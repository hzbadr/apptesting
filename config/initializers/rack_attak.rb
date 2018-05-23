Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

Rack::Attack.throttle("requests by user", limit: 10, period: 2.minutes) do |request|
  request.get_header("HTTP_AUTHORIZATION") if request.path.include?('/public/')
end

Rack::Attack.throttle("logins/email", limit: 5, period: 20.seconds) do |req|
  if req.path == '/auth/login' && req.post?
    req.params['email']
  end
end
