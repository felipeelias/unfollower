require "mongo_mapper"

MongoMapper.config = {
  :development => {"uri" => "mongodb://localhost/unfollower-tracker"},
  :production  => {"uri" => ENV["MONGOHQ_URL"]}
}

MongoMapper.connect(Sinatra::Base.environment)

Dir["models/*.rb"].each {|f| require f}