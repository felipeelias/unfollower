require 'spec_helper'

describe FollowersStore do
  subject { FollowersStore.new("#{ROOT}/spec/fixtures/simple_dump.yml") }
  
  it do
    should have(2).followers
  end
  
  it "should add a new follower" do
    follower = FollowersHistory.new([1, 2])
    
    expect { subject.add follower }.to change { subject.count }.from(2).to(3)
  end
  
  it "should load all followers from file" do
    followers = subject.followers
    followers.should have(2).itens
    followers.first.should be_an_instance_of(FollowersHistory)
  end
  
  it "should dump correctly the followers" do
    File.should_receive(:open).with("#{ROOT}/spec/fixtures/simple_dump.yml", "w")
    subject.should_receive(:load)
    subject.dump!
  end
  
  it "should convert to array" do
    followers_to_array = subject.to_array
    followers_to_array.should be_an_instance_of(Array)
    followers_to_array.first.should be_an_instance_of(Array)
  end
end

describe FollowersStore, "with an empty file" do
  let(:path) { "#{ROOT}/spec/fixtures/empty_dump.yml" }
  
  before do
    File.open(path, "w").close
  end
  
  after do
    File.delete(path)
  end

  it "should create an empty array" do
    store = FollowersStore.new(path)
    
    store.followers.should == []
  end
end