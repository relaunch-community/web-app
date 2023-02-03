redis_config = if ENV['REDIS_URL'].present?
                 # Fun config to use with Elasticache and the new redis-client gem
               redis_url = ENV['REDIS_URL']
               redis_url = /.*6379$/.match(redis_url) ? redis_url + "/" + ENV['REDIS_DATABASE'] : redis_url
               c = { url: redis_url }
               c[:password] = ENV['REDIS_PASSWORD'] if ENV['REDIS_PASSWORD'].present?
               c[:ssl_params] = { verify_mode: OpenSSL::SSL::VERIFY_NONE }

               c
             else
               { url: 'redis://localhost:6379/1' }
               end

Sidekiq.configure_server do |config|
  config.redis = redis_config
end

Sidekiq.configure_client do |config|
  config.redis = redis_config
end
