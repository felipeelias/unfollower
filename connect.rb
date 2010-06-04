require 'rubygems'
require 'twitter'
require 'helpers/config_store'
require 'pp'

config = ConfigStore.new("twitter.yml")
oauth = Twitter::OAuth.new(config['token'], config['secret'])

if config['atoken'] && config['asecret']
  oauth.authorize_from_access(config['atoken'], config['asecret'])
  twitter = Twitter::Base.new(oauth)
  pp twitter.friends.map { |friend| friend.screen_name }.join(', ')

elsif config['rtoken'] && config['rsecret'] && config['pin']
  oauth.authorize_from_request(config['rtoken'], config['rsecret'], config['pin'])

  config.update({
    'atoken'  => oauth.access_token.token,
    'asecret' => oauth.access_token.secret,
  }).delete('rtoken', 'rsecret', 'pin')
  
  puts "> Now you're authorized!"
else
  config.update({
    'rtoken'  => oauth.request_token.token,
    'rsecret' => oauth.request_token.secret,
  })

  # authorize in browser
  %x(open #{oauth.request_token.authorize_url})

  print "> what was the PIN twitter provided you with? "
  pin = gets.chomp
  
  config.update({'pin' => pin}) if !pin.empty?
end
