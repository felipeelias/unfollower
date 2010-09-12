require 'bundler/setup'
require 'mongo_mapper'

MongoMapper.config = {
  :development  => {"uri" => "mongodb://localhost/unfollower-tracker"},
  :test         => {"uri" => "mongodb://localhost/unfollower-tracker-test"},
  :production   => {"uri" => ENV["MONGOHQ_URL"]}
}

Dir["models/*.rb"].each {|f| require f}
