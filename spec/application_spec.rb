require 'spec_helper'

describe "Application" do
  include Rack::Test::Methods

  def app
    @app ||= Sinatra::Application.new
  end
  
  def session
    last_request.env['rack.session']
  end
  
  def parse_json_fixture fixture_name
    JSON.load(File.open("#{File.dirname(__FILE__)}/fixtures/#{fixture_name}.json")).methodize!
  end

  it "should redirect to the twitter login" do
    oauth = mock(OAuth::Consumer)
    OAuth::Consumer.should_receive(:new).and_return(oauth)
    
    oauth.stub!(:get_request_token).and_return({:token => 't', :secret => 's', :authorize_url => "http://auth_url", }.methodize!)
    
    get '/request'
    
    session[:request_token].should == 't'
    session[:request_secret].should == 's'
    
    last_response.headers['Location'].should == 'http://auth_url'
    last_response.should be_redirect
  end
  
  it "should receive the auth token" do
    oauth = mock(OAuth::Consumer)
    OAuth::Consumer.should_receive(:new).and_return(oauth)

    request_token = mock(OAuth::RequestToken)
    OAuth::RequestToken.should_receive("new").and_return(request_token)
    request_token.should_receive(:get_access_token).and_return({:token => "token", :secret => "secret", }.methodize!)
    
    get '/auth', { :oauth_verifier => 'some_key' }

    session[:access_token].should == 'token'
    session[:access_secret].should == 'secret'
    
    last_response.should be_redirect
  end

  it "should show index page if logged in" do
    pending "TODO: for some reason that i don't know, the session is not working here"

    oauth = mock(OAuth::Consumer)
    OAuth::Consumer.should_receive(:new).and_return(oauth)
    twitter = mock(Twitter::Client)
    Twitter::Client.should_receive(:new).and_return(twitter)

    twitter.stub!(:verify_credentials)

    get '/', {}, { 'rack.session' => { :access_token => 'token', :access_secret => 'secret' } }

    last_response.should_not be_redirect
  end

  it "should redirect to login if not logged in" do
    get '/'
    
    last_response.should be_redirect
  end
end