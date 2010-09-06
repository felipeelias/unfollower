require 'yaml'

module Application
  class TwitterConfig < Struct.new(:token, :secret, :callback)
    def initialize(environment = Application.env)
      yaml = YAML.load(File.read("#{Application.root}/twitter.yml"))
      config = yaml[environment]
      super(config['consumer_token'], config['consumer_secret'], config['oauth_callback'])
    end
  end
end