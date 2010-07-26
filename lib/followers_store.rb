require 'yaml'

class FollowersStore
  attr_reader :followers
  
  def initialize(file)
    @file = file
    load
  end
  
  def add(follower)
    if @followers.last && @followers.last != follower
      @followers << follower
    end
  end
  
  def count
    @followers.size
  end
  
  def dump!
    File.open(@file, "w") { |f| f.write(to_array) }
    load
  end
  
  def to_array
    @followers.map {|follower| follower.followers }
  end
  
  private
  
  def load
    @followers = []
    file = File.new(@file) rescue ""
    yaml = YAML.load(file)
    
    if yaml
      @followers = yaml.map do |history|
        FollowersHistory.new(history)
      end      
    end
  end
  
end