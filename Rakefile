require 'yaml'
require File.expand_path(File.dirname(__FILE__) + '/lib/initializer')

desc "copy twitter config"
task :copy_config do
  twitter_config = {
    "production" => {
      "consumer_token" => ENV['CONSUMER_TOKEN'],
      "consumer_secret" => ENV['CONSUMER_SECRET'],
      "oauth_callback" => ENV['OAUTH_CALLBACK']
    }
  }
  File.open("twitter.yml", "w") { |f| f.write(YAML.dump(twitter_config)) }
end