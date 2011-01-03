require 'boot'
require 'sinatra'
require 'rack/test'
require 'database_cleaner'
require 'rspec'
require 'webmock/rspec'

Dir['spec/support/*.rb'].each { |f| require f }

configure do
  set :environment, :test
  set :run, false
  set :raise_errors, true
  set :logging, false
  set :views, File.dirname(__FILE__) + '/../views'
end

require File.expand_path(File.dirname(__FILE__) + '/../application')

Rspec.configure do |config|
  
  include SessionHelper
  
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end