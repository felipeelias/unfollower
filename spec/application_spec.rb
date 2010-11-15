require 'spec_helper'

describe "Application" do
  include Rack::Test::Methods

  # before do
  #   oauth = Twitter::OAuth.new("token", "secret")
  #   @access_token = OAuth::AccessToken.new(oauth.consumer, "atoken", "asecret")
  #   oauth.stub!(:access_token).and_return(@access_token)
  #   @twitter = Twitter::Base.new(oauth)
  # end

  def app
    Sinatra::Application.new
  end

  it "should show index page if logged in" do
    pending
    get '/', {}, { 'rack.session' => {:current_user => 1} }
    
    last_response.should_not be_redirect
  end

  it "should redirect to login if not logged in" do
    get '/'
    
    last_response.should be_redirect
  end
end