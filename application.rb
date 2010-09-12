require 'boot'
require 'sinatra'
require 'twitter'
require 'lib/initializer'
require "lib/twitter_users_lookup"

MongoMapper.connect(Sinatra::Base.environment)

enable :sessions

before do
  @store = FollowersStore.new

  session[:oauth] ||= {}
  
  @oauth ||= Twitter::OAuth.new(Config.token, Config.secret)
  
  if !session[:oauth][:access_token].nil? && !session[:oauth][:access_token_secret].nil?
    @oauth.authorize_from_access(session[:oauth][:access_token], session[:oauth][:access_token_secret])
    @client = Twitter::Base.new(@oauth)
  end
  
end

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
  
  def logged_in?
    !session[:oauth].empty?
  end
end

def login_required
  redirect '/login' if not logged_in?
end

get '/request' do
  @request_token = @oauth.request_token(:oauth_callback => Config.callback)
  session[:oauth][:request_token] = @request_token.token
  session[:oauth][:request_token_secret] = @request_token.secret

  redirect @request_token.authorize_url
end

get '/auth' do
  request_token = session[:oauth][:request_token]
  request_token_secret = session[:oauth][:request_token_secret]
  oauth_verifier = params[:oauth_verifier]
  
  @oauth.authorize_from_request(request_token, request_token_secret, oauth_verifier)

  session[:oauth][:access_token] = @oauth.access_token.token
  session[:oauth][:access_token_secret] = @oauth.access_token.secret

  redirect "/"
end

get '/login' do
  erb :login
end

get '/logout' do
  session[:oauth] = {}
  redirect '/'
end

get '/' do
  login_required
  
  followers_ids = @store.unfollowers.reverse
  followers = @client.users_lookup(followers_ids)
  @followers = followers.sort_by { |follower| followers_ids.index(follower.id) }
  
  @user_info = @client.verify_credentials
  erb :index
end

get '/update' do
  begin
    ids = @client.follower_ids
    followers_history = FollowersHistory.new(ids)
    @store.add(followers_history)    
    
    redirect '/'
  rescue => @e
    erb :error
  end
end