Sidetiq.configure do |config|
  # Use UTC instead of local time.
  config.utc = true
end

# Require all existing scheduled jobs.
unless Rails.configuration.eager_load
  Dir[Rails.root.join("app/workers/scheduled/**/*.rb")].each { |f| require f }
end
