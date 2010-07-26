require 'spec_helper'

describe FollowersStore do
  subject { FollowersStore.new(fixture_path_for(:simple_dump)) }
  
  it do
    should have(2).followers
  end
  
  it "should add a new follower" do
    follower = FollowersHistory.new([1, 2])
    
    expect { subject.add follower }.to change { subject.count }.from(2).to(3)
  end

  it "should not add a new follower if is the same as last history" do
    follower = FollowersHistory.new([2, 3])
    
    lambda { subject.add follower }.should_not change { subject.count }
  end
  
  it "should load all followers from file" do
    followers = subject.followers
    followers.should have(2).itens
    followers.first.should be_an_instance_of(FollowersHistory)
  end
  
  it "should dump correctly the followers" do
    File.should_receive(:open).with(fixture_path_for(:simple_dump), "w")
    subject.should_receive(:load)
    subject.dump!
  end
  
  it "should convert to array" do
    followers_to_array = subject.to_array
    followers_to_array.should be_an_instance_of(Array)
    followers_to_array.first.should be_an_instance_of(Array)
  end
end

describe FollowersStore, "with an empty and nonexistent file" do
  it "should create an empty array" do
    store = FollowersStore.new(fixture_path_for(:empty_dump))
    
    store.followers.should == []
  end
end