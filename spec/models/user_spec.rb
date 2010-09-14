require 'spec_helper'

describe User do
  it { should respond_to(:twitter_id) }
  it { should respond_to(:last_followers) }
  
  it "should not create a invalid user" do
    User.new.should_not be_valid
  end
  
  it "should have default empty array for unfollowers" do
    user = User.create(:twitter_id => 0, :last_followers => [1])
    user.unfollowers.should be_empty
  end
end

describe User, "handling unfollowers" do
  let(:user) { User.create(:twitter_id => 0, :last_followers => [1, 2, 3], :unfollowers => [4]) }
  
  it "should update the unfollowers list if have changes" do
    new_followrers_list = [2, 3]
    user.check_unfollowers(new_followrers_list)
    user.unfollowers.should == [1, 4]
  end
  
  it "should not update the unfollowers list if does not have changes" do
    same_followrers_list = [1, 2, 3]
    user.check_unfollowers(same_followrers_list)
    user.unfollowers.should == [4]
  end
end