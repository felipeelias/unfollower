require 'spec_helper'

describe "Application" do
  include Rack::Test::Methods
  include TwitterStubs

  def app
    Sinatra::Application.new
  end
  
  it "should redirect to login if not logged in" do
    get '/'
    last_response.should be_redirect
  end
  
  describe "/request" do
    before do
      stub_oauth_request_token!
    end
    
    it "should redirect to the twitter login" do
      get '/request'

      session[:request_token].should == 't'
      session[:request_secret].should == 's'

      last_response.headers['Location'].should =~ /api.twitter.com/
      last_response.should be_redirect
    end
  end
  
  describe "/auth" do
    before do
      stub_oauth_access_token!
    end
    
    it "should receive the auth token from twitter" do
      get '/auth', { :oauth_verifier => 'some_key' }

      session[:access_token].should == 'at'
      session[:access_secret].should == 'as'

      last_response.should be_redirect
    end
  end
  
  describe "/index" do
    before do
      session[:access_token] = 'token'
      session[:access_secret] = 'secret'
      stub_verify_credentials!
    end

    it "should show index page if logged in" do
      get '/'

      last_response.should_not be_redirect
    end
  end
end