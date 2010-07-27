require 'rubygems'
require 'sinatra'
require 'twitter'
require 'active_support/core_ext/string/output_safety'
require 'lib/initializer'
require 'helpers/config_store'

store = FollowersStore.new
config = ConfigStore.new("twitter.yml")
oauth = Twitter::OAuth.new(config['token'], config['secret'])

def h(string)
  ERB::Util.html_escape(string)
end

get '/' do
  @followers = store.histories
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

@@ error
<h2>error happens</h2>
<pre>
  <%=h @e %>
</pre>