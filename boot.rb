require 'bundler/setup'
require 'ostruct'

APP_CONFIG = {
  :token => ENV['CONSUMER_TOKEN'], 
  :secret => ENV['CONSUMER_SECRET'], 
  :callback => ENV['OAUTH_CALLBACK']
}

require 'mongo_mapper'

MongoMapper.config = {
  :development  => {"uri" => "mongodb://localhost/unfollower-tracker"},
  :test         => {"uri" => "mongodb://localhost/unfollower-tracker-test"},
  :production   => {"uri" => ENV["MONGOHQ_URL"]}
}

Dir["models/*.rb"].each {|f| require f}
