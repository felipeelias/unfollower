require File.expand_path(File.dirname(__FILE__) + '/../lib/initializer')

Application.env = 'test'

Spec::Runner.configure do |config|
  include Application::TestHelpers
end
