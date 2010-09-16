require 'spec_helper'

describe "Application" do
  include Rack::Test::Methods

  def app
    @app ||= Sinatra::Application
  end

  it "should show index page if logged in" do
    pending
    
    oauth = mock(Twitter::OAuth)
    oauth.should_receive(:authorize_from_access).with("XYZ", "XYZIOP")
    twitter = mock(Twitter::Base)
    twitter.should_receive(:new).with(oauth)
    
    get '/', {}, {'rack.session' => {:oauth => {:access_token => "XYZ", :access_token_secret => "XYZIOP"}}}
    
    last_response.should_not be_redirect
  end

  it "should redirect to login if not logged in" do
    get '/'
    last_response.should be_redirect
  end
end