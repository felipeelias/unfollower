# TODO: possible methods
# FollowersHistory.all (loads all files from dump ordered by date desc)
# FollowersHistory.new(date, followers)
# FollowersHistory.new.diff another
class FollowersHistory
  attr_reader :date, :followers
  
  def initialize(opts)
    @date, @followers = opts[:date], opts[:followers]
  end
end