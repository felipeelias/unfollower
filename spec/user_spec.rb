require 'spec_helper'

describe User do
  it { should respond_to(:twitter_id) }
  
  it "should create a new user" do
    User.create.should be_true
  end
end