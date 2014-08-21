class AddTweetAsToReTweets < ActiveRecord::Migration
  def change
    add_column :re_tweets, :tweet_as, :int
  end
end
