# The host 'redis' is added by Docker when containers are linked.
url = "redis://redis:6379"

Sidekiq.configure_server do |config|
  config.redis = { url: url }
end

Sidekiq.configure_client do |config|
  config.redis = { url: url }
end
