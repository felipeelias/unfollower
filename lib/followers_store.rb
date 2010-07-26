module FollowersStore
  @@db_file = DB_FILE
  
  class << self
    def db_file
      @@db_file
    end
  end
end