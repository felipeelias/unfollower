require 'rubygems'
require 'sinatra'
require 'twitter'
require 'active_support/core_ext/string/output_safety'
require 'lib/initializer'

enable :sessions

config = Application::TwitterConfig.new("#{Application.root}/twitter.yml", Application.env)
store = FollowersStore.new

before do
  session[:oauth] ||= {}
  
  @oauth ||= Twitter::OAuth.new(config.token, config.secret)
  
  if !session[:oauth][:access_token].nil? && !session[:oauth][:access_token_secret].nil?
    @oauth.authorize_from_access(session[:oauth][:access_token], session[:oauth][:access_token_secret])
    @client = Twitter::Base.new(@oauth)
  end
  
end

def h(string)
  ERB::Util.html_escape(string)
end

get '/timeline' do
  if @client
    @timeline = @client.user_timeline.map { |status| status.text }
    erb :timeline
  else
    erb :auth
  end
end

get '/request' do
  @request_token = @oauth.request_token(:oauth_callback => config.callback)
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

  redirect "/timeline"
end

get '/logout' do
  session[:oauth] = {}
  redirect '/timeline'
end

get '/' do
  @followers = store.histories
  erb :index
end

get '/update' do
  begin
    ids = @client.follower_ids.inspect    
    followers_history = FollowersHistory.new(ids)
    store.add(followers_history)    
    
    redirect '/'
  rescue => @e
    erb :error
  end
end

__END__
@@ layout
<html>
  <head>
    <title>Unfollower Tracker</title>
  </head>
  <body>
    <%= yield %>
  </body>
</html>

@@ index
<h1 id="hello">Your unfollowers</h1>
<a href="/update">Update the unfollowers list</a>
<h3>Total of <%= @followers.count %> alteration(s)</h3>
<ul>
<% @followers.each do |follower| %>
  <li><%=h follower.followers.inspect %></li>
<% end %>
</ul>

@@auth
<a href="/request">Sign-in with twitter</a>

@@timeline
<a href="/logout">Log Out</a>
<ul>
  <% @timeline.each do |status| %>
    <li><%=h status %></li>
  <% end %>
</ul>

@@ error
<h2>error happens</h2>
<pre>
  <%=h @e %>
</pre>