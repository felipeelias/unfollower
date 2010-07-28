require 'spec_helper'

describe Application::TwitterConfig do
  subject { Application::TwitterConfig.new("#{Application.root}/spec/fixtures/sample_twitter_config.yml") }
  
  it { should respond_to(:token) }
  it { should respond_to(:secret) }
  it { should respond_to(:callback) }
  
  context "in default environment" do
    it "should have development token" do
      subject.token == "DEV_TOKEN"
    end
    
    it "should have development secret" do
      subject.secret == "DEV_SECRET"
    end
    
    it "should have development callback" do
      subject.callback == "http://dev_callback"
    end
  end
end

describe Application::TwitterConfig, "in another environment" do
  subject { Application::TwitterConfig.new("#{Application.root}/spec/fixtures/sample_twitter_config.yml", 'production') }

  it "should have production token" do
    subject.token == "PROD_TOKEN"
  end
  
  it "should have production secret" do
    subject.secret == "PROD_SECRET"
  end
  
  it "should have production callback" do
    subject.callback == "http://prod_callback"
  end
end