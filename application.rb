require 'boot'
require 'sinatra'
require 'twitter'
require 'lib/twitter_users_lookup'

MongoMapper.connect(Sinatra::Base.environment)

enable :sessions unless Sinatra::Base.environment == :test

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
  
  def logged_in?
    session[:current_user]
  end

  def user_info
    @user_info ||= client.verify_credentials
  end
  
  def current_user
    @current_user ||= User.find_or_create_by_twitter_id(user_info.id)
  end
end

def oauth
  @oauth ||= Twitter::OAuth.new(APP_CONFIG[:token], APP_CONFIG[:secret])
end

def client
  oauth.authorize_from_access(session[:access_token], session[:access_secret])
  Twitter::Base.new(oauth)
end

def login_required
  redirect '/login' if not logged_in?
end

def authorized?
  params[:oauth_verifier] && !params[:denied]
end

get '/request' do
  request_token = oauth.request_token(:oauth_callback => APP_CONFIG[:callback])
  session[:request_token] = request_token.token
  session[:request_secret] = request_token.secret

  redirect request_token.authorize_url
end

get '/auth' do
  if authorized?
    oauth.authorize_from_request(session[:request_token], session[:request_secret], params[:oauth_verifier])
    
    session[:access_token] = oauth.access_token.token
    session[:access_secret] = oauth.access_token.secret
    session[:current_user] = current_user.id
    
    redirect "/"
  else
    redirect "/error"
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
  
  ids = client.follower_ids
  current_user.check_unfollowers!(ids)
  
  redirect '/'
end