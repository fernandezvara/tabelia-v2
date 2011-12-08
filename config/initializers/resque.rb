require "resque/server"

rails_root = ENV['RAILS_ROOT'] || File.dirname(__FILE__) + '/../..'
rails_env = ENV['RAILS_ENV'] || 'production'

case rails_env
when 'development'
  Resque.redis = "localhost:6379"
when 'test'
  Resque.redis = "localhost:6379"
when 'production'
  Resque.redis  = "server5-data.retocontinuo.local:6379"
end
#resque_config = YAML.load_file(rails_root + '/config/resque.yml')
#Resque.redis = resque_config[rails_env]