class AddPopularityToRetweets < ActiveRecord::Migration
  def change
    add_column :re_tweets, :popularity, :int
  end
end
