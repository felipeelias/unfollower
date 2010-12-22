require 'boot'
require 'sinatra'

configure do
  set :environment, :test
  set :run, false
  set :raise_errors, true
  set :logging, false
  set :views, "#{File.dirname(__FILE__)}/../../views"
end

require File.join(File.dirname(__FILE__), '..', '..', 'application.rb')

require 'rspec/expectations'
require 'capybara/cucumber'

Capybara.app = Sinatra::Application
Capybara.default_selector = :css

require 'database_cleaner'
require 'database_cleaner/cucumber'

DatabaseCleaner.strategy = :truncation
