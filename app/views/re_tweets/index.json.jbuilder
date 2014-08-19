json.array!(@re_tweets) do |re_tweet|
  json.extract! re_tweet, :id, :tweet_id, :tweeter, :tweet_text, :retweet_text, :did_retweet
  json.url re_tweet_url(re_tweet, format: :json)
end
