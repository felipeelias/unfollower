require 'singleton'

class FollowersStore
  include Singleton
  
  def initialize
    @@db_file = DB_FILE
  end
  
  def db_file
    @@db_file
  end
end