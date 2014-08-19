class CreateReTweets < ActiveRecord::Migration
  def change
    create_table :re_tweets do |t|
      t.integer :tweet_id, :limit => 8
      t.string :tweeter
      t.string :tweet_text
      t.string :retweet_text
      t.boolean :did_retweet

      t.timestamps
    end
  end
end
