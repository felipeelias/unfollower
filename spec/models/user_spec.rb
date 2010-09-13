require 'spec_helper'

describe User do
  it { should respond_to(:twitter_id) }
  
  it "should not create a invalid user" do
    User.new.should_not be_valid
  end
end