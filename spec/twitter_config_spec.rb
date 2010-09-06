require 'spec_helper'

describe Application::TwitterConfig do

  it { should respond_to(:token) }
  it { should respond_to(:secret) }
  it { should respond_to(:callback) }  
  
  it "should have token set" do
    subject.token.should == "TEST_TOKEN"
  end
  
  it "should have secret set" do
    subject.secret.should == "TEST_SECRET"
  end
  
  it "should have callback set" do
    subject.callback.should == "http://test_callback"
  end
end
