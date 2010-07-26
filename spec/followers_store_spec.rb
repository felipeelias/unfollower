require 'spec_helper'

describe "FollowersStore" do
  it "should have path to db file" do
    FollowersStore.instance.db_file.should == DB_FILE
  end
end