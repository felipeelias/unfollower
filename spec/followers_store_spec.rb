require 'spec_helper'

describe FollowersStore do
  use_fixture :simple_dump
  
  it { should have(2).histories }

  it "should create instances of FollowersHistory" do
    subject.histories.each do |history|
      history.should be_an_instance_of(FollowersHistory)
    end
  end  
  
  it "should count the number of histories" do
    subject.count.should == 2
  end
  
  it "should add a new follower" do
    follower = FollowersHistory.new([1, 2])
    
    lambda { subject.add(follower) }.should change { subject.count }.from(2).to(3)
  end

  it "should not add a new follower if is the same as last history" do
    follower = FollowersHistory.new([2, 3])
    
    lambda { subject.add follower }.should_not change { subject.count }
  end
  
  it "should convert to array" do
    followers_to_array = subject.to_array
    followers_to_array.should be_an_instance_of(Array)
    followers_to_array.first.should be_an_instance_of(Array)
  end
end

describe FollowersStore, "with an empty and nonexistent file" do
  use_fixture :empty_dump
  
  it "should create an empty array" do
    subject.histories.should == []
  end
end