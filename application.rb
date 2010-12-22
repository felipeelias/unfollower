require 'boot'
require 'sinatra'
require 'twitter'
require 'oauth'

MongoMapper.connect(Sinatra::Base.environment)

enable :sessions unless Sinatra::Base.environment == :test

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
  
  def logged_in?
    session[:access_token] && session[:access_secret]
  end

  def user_info
    @user_info ||= client.verify_credentials
  end
  
  def current_user
    @current_user ||= User.find_or_create_by_twitter_id(user_info.id)
  end
end

def oauth
  @oauth ||= OAuth::Consumer.new(ENV['CONSUMER_TOKEN'], ENV['CONSUMER_SECRET'], :site => 'http://api.twitter.com', :request_endpoint => 'http://api.twitter.com', :sign_in => true)
end

def client
  Twitter.configure do |c|
    c.consumer_key = ENV['CONSUMER_TOKEN']
    c.consumer_secret = ENV['CONSUMER_SECRET']
    c.oauth_token = session[:access_token]
    c.oauth_token_secret = session[:access_secret]
  end
  @client ||= Twitter::Client.new
end

def login_required
  redirect '/login' if not logged_in?
end

def authorized?
  params[:oauth_verifier]
end

get '/request' do
  request_token = oauth.get_request_token(:oauth_callback => APP_CONFIG[:callback])
  session[:request_token] = request_token.token
  session[:request_secret] = request_token.secret

  redirect request_token.authorize_url
end

get '/auth' do
  if authorized?
    request_token = OAuth::RequestToken.new(oauth, session[:request_token], session[:request_secret])
    access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])

    session[:access_token] = access_token.token
    session[:access_secret] = access_token.secret
    
    redirect "/"
  else
    erb "/error"
  end
end

get '/login' do
  erb :login
end

get '/logout' do
  session[:current_user] = nil
  redirect '/'
end

get '/' do
  login_required
  
  @followers = []
  
  followers_ids = current_user.unfollowers
  
  if !followers_ids.empty?
    followers = client.users_lookup(followers_ids)
    @followers = followers.sort_by { |follower| followers_ids.index(follower.id) }    
  end
  
  erb :index
end

get '/update' do
  login_required
  
  ids = client.follower_ids.ids
  current_user.check_unfollowers!(ids)
  
  redirect '/'
end
