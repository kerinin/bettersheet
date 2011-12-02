unless Rails.env.production?
  ENV["REDISTOGO_URL"] = 'redis://localhost:6379'
end

uri = URI.parse(ENV["REDISTOGO_URL"])
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

Split.redis = ENV["REDISTOGO_URL"]