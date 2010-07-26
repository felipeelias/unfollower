require 'rubygems'
require 'sinatra'
require 'twitter'
require 'lib/initializer'
require 'helpers/config_store'

store = FollowersStore.new("#{ROOT}/db/followers.yaml")
config = ConfigStore.new("twitter.yml")
oauth = Twitter::OAuth.new(config['token'], config['secret'])

get '/' do
  @followers = store.followers
  erb :index
end

get '/update' do
  begin
    oauth.authorize_from_access(config['atoken'], config['asecret'])
    client = Twitter::Base.new(oauth)
    
    ids = client.follower_ids.inspect
    puts ids.inspect
    
    followers_history = FollowersHistory.new(ids)
    puts followers_history.inspect

    store.add(followers_history)    
    store.dump!
    
    redirect '/'
  rescue => e
    @e = e
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
<ul>
<% @followers.each do |follower| %>
  <li><%= follower.inspect %></li>
<% end %>
</ul>

@@ error
<h2>error happens</h2>
<pre>
  <%= @e.inspect %>
</pre>