$twitter = Twitter::REST::Client.new do |config|
    
  config.consumer_key = Rails.configuration.consumer_key
  config.consumer_secret = Rails.configuration.consumer_secret
  config.access_token = Rails.configuration.access_token
  config.access_token_secret = Rails.configuration.access_token_secret
  
end