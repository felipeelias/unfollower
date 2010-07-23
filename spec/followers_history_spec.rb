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

#TODO: refactor this fuck
describe FollowersHistory, "loading all history" do
  it "should load history from yaml file" do
    raw_yaml = "--- \n- - 1\n  - 2\n- - 2\n  - 3\n"
    File.should_receive(:open).with(File.expand_path(FollowersHistory::YAML_DUMP_FILE)).and_return(raw_yaml)
    YAML.should_receive(:load).with(raw_yaml).and_return([[1, 2], [2, 3]])
    
    FollowersHistory.all.should include([1, 2], [2, 3])
  end
end
