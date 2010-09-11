require File.dirname(__FILE__) + '/../lib/initializer'

Application.env = 'production'

store = FollowersStore.new
files = Dir["#{Application.root}/dump/*.yml"]

files.sort!

array_with_followers = files.map do |file| 
  YAML.load(File.read(file))
end

array_with_followers.each do |item|
  store.add(FollowersHistory.new(item))
end
