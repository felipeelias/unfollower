require 'yaml'
# TODO: possible methods
# FollowersHistory.all (loads all files from dump ordered by date desc)
# FollowersHistory.new(date, followers)
# FollowersHistory.new.diff another
class FollowersHistory
  @@db_file = DB_FILE
  
  attr_reader :followers
  
  def initialize(followers)
    @followers = followers
  end
  
  def diff(another)
    another.followers - followers
  end
  
  def ==(another)
    another.followers == followers
  end
  
  class << self
    def all
      YAML.load(File.read(db_file)).map do |history|
        FollowersHistory.new(history)
      end
    end
    
    def db_file
      @@db_file
    end
    
    def db_file=(path)
      @@db_file = path
    end
  end
end