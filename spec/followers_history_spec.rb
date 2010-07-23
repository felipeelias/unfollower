require 'lib/followers_history'

describe FollowersHistory, ".new" do
  subject { FollowersHistory.new([111, 222]) }
  
  it "should have followers" do
    subject.should have(2).followers
    subject.followers.should include(111, 222)
  end
end
  
describe FollowersHistory, "comparing histories" do
  let(:old_history) { FollowersHistory.new([111, 222, 333]) }
  let(:new_history) { FollowersHistory.new([111]) }

  it "should show the ids of the unfollowers" do
    new_history.diff(old_history).should == [222, 333]
  end
  
  it "should compare 2 histories" do
    same_history = FollowersHistory.new([111, 222, 333])
    old_history.should == same_history
  end
end
