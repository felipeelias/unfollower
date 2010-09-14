class User
  include MongoMapper::Document
  
  key :twitter_id, Integer, :required => true
  key :last_followers, Array
  key :unfollowers, Array
  
  def check_unfollowers(new_list)
    list = last_followers - new_list
    unfollowers.unshift(*list)
  end
end
