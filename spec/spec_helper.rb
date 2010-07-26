require File.expand_path(File.dirname(__FILE__) + '/../lib/initializer')
require "#{ROOT}/lib/followers_history"
require "#{ROOT}/lib/followers_store"

Spec::Runner.configure do |config|
  def use_fixture(fixture_name)
    before do
      FollowersHistory.store = FollowersStore.new(fixture_path_for(fixture_name))
    end
  end
  
  def fixture_path_for(fixture_name)
    "#{ROOT}/spec/fixtures/#{fixture_name}.yml"
  end
end
