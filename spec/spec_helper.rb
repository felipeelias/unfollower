require File.expand_path(File.dirname(__FILE__) + '/../lib/initializer')
require "#{ROOT}/lib/followers_history"

Spec::Runner.configure do |config|
  # using fixture for tests
  FollowersHistory.db_file = ROOT + "/spec/fixtures/simple_dump.yml"
end
