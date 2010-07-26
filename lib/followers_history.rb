class FollowersHistory
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
      store.followers
    end
    
    def store
      @@store ||= FollowersStore.new(DB_FILE)
    end
    
    def store=(follower_store)
      @@store = follower_store
    end
  end
end