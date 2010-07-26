require 'spec_helper'

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

describe FollowersHistory, "loading all history" do
  before do
    path = FollowersHistory::YAML_DUMP_FILE = ROOT + "/spec/fixtures/simple_dump.yml"
    raw_yaml = File.read(path)
    
    FollowersHistory.should_receive(:open).with(path).and_return(raw_yaml)
  end
  
  it "should load history from yaml file" do
    FollowersHistory.all.should include([1, 2], [2, 3])
  end
end
