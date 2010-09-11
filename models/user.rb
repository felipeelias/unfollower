class User
  include MongoMapper::Document
  
  key :twitter_id, Integer
end
