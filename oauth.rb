require 'rubygems'
require 'twitter'
require 'helpers/config_store'

config  = ConfigStore.new("twitter.yml")
oauth   = Twitter::OAuth.new(config['token'], config['secret'])
rtoken  = oauth.request_token.token
rsecret = oauth.request_token.secret

puts "> redirecting you to twitter to authorize..."
%x(open #{oauth.request_token.authorize_url})

print "> what was the PIN twitter provided you with? "
pin = gets.chomp

begin
  oauth.authorize_from_request(rtoken, rsecret, pin)

  twitter = Twitter::Base.new(oauth)
  twitter.user_timeline.each do |tweet|
    puts "#{tweet.user.screen_name}: #{tweet.text}"
  end
rescue OAuth::Unauthorized
  puts "> FAIL!"
end