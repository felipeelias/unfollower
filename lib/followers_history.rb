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
end