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
end