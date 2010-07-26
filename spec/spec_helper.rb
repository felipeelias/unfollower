require File.expand_path(File.dirname(__FILE__) + '/../lib/initializer')
require "#{ROOT}/lib/followers_history"
require "#{ROOT}/lib/followers_store"

Spec::Runner.configure do |config|
  def use_fixture(fixture)
    FollowersHistory.db_file = ROOT + "/spec/fixtures/#{fixture}.yml"
  end
end
