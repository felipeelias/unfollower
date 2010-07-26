require 'spec_helper'

describe FollowersHistory, ".new" do
  subject { FollowersHistory.new([111, 222]) }
  
  it do
    subject.should have(2).followers
  end
  
  it do
    subject.followers.should include(111, 222)
  end
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

describe FollowersHistory, "loading all history" do
  before do
    FollowersHistory.store = FollowersStore.new("#{ROOT}/spec/fixtures/simple_dump.yml")
  end
  
  it "should load history" do
    history = FollowersHistory.all

    history.first.followers.should == [1, 2]
    history.last.followers.should == [2, 3]
  end
end

describe FollowersHistory, "saving a new history" do
  before do
    FollowersHistory.store = FollowersStore.new("#{ROOT}/spec/fixtures/save_dump.yml")
  end
  
  it "should add a new history if different"
end