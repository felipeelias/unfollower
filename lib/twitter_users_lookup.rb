class Twitter::Base
  def users_lookup(user_ids)
    perform_get("/1/users/lookup.json", :query => { :user_id => user_ids.join(',') })
  end
end
