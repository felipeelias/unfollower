require 'sinatra'
require 'rack/test'

require File.expand_path(File.dirname(__FILE__) + '/../lib/initializer')

# set test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

Application.env = 'test'

Spec::Runner.configure do |config|
  include Application::TestHelpers
end
