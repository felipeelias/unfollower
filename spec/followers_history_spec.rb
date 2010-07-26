require 'spec_helper'

describe FollowersHistory, ".new" do
  subject { FollowersHistory.new([111, 222]) }
  
  it { subject.should have(2).followers }
  it { subject.followers.should include(111, 222) }
end
  
describe FollowersHistory, "comparing histories" do
  let(:old_history) { FollowersHistory.new([111, 222, 333]) }

  it "should show the ids of the unfollowers" do
    new_history = FollowersHistory.new([111])
    new_history.diff(old_history).should == [222, 333]
  end
  
  it "should compare 2 histories" do
    same_history = FollowersHistory.new([111, 222, 333])
    old_history.should == same_history
  end
end
