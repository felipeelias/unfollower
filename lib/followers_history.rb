# TODO: possible methods
# FollowersHistory.all (loads all files from dump ordered by date desc)
# FollowersHistory.new(date, followers)
# FollowersHistory.new.diff another
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