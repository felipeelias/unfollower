require 'yaml'

module Application
  class TwitterConfig < Struct.new(:token, :secret, :callback)
    def initialize(file, environment = 'development')
      @config = YAML.load(File.read(file))[environment]
      super(@config['consumer_token'], @config['consumer_secret'], @config['oauth_callback'])
    end
  end
end