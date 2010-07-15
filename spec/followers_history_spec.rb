require 'lib/followers_history'

describe FollowersHistory do
  subject { FollowersHistory.new }
  it do
    should_not be_valid
  end
end