require 'spec_helper'

describe "Application" do
  include Rack::Test::Methods

  def app
    @app ||= Sinatra::Application
  end

  it "should redirect to login if not logged in" do
    get '/'
    last_response.should be_redirect
  end
end