require 'lib/followers_history'

describe FollowersHistory do
  describe "creating a new FollowersHistory" do
    subject { FollowersHistory.new(:date => "20101122", :followers => [111, 222]) }
    
    it "should have followers" do
      subject.followers.should == [111, 222]
    end
    
    it "should have a date identifier" do
      subject.date.should == "20101122"
    end
  end
  describe "comparing histories" do
    let(:old_history) { FollowersHistory.new(:date => "20101122", :followers => [111, 222, 333]) }
    let(:new_history) { FollowersHistory.new(:date => "20101123", :followers => [111]) }

    it "should show the ids of the unfollowers" do
      new_history.diff(old_history).should == [222, 333]
    end
  end
end