require File.expand_path(File.dirname(__FILE__) + '/../lib/initializer')

Spec::Runner.configure do |config|
  def use_fixture(fixture_name)
    before do
      FollowersHistory.store = FollowersStore.new(fixture_path_for(fixture_name))
    end
  end
  
  def fixture_path_for(fixture_name)
    "#{Application.root}/spec/fixtures/#{fixture_name}.yml"
  end
end
