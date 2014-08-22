namespace :twitter do
  
  desc "search twitter"
  task search: :environment do
    ReTweet.search_twitter
    ReTweet.search_billy_goat
  end
  
  desc "search twitter nerd"
  task search_nerd: :environment do
    ReTweet.search_nerd_stuff
  end
  
  
  desc "test cheeseborger"
  task test_schleepbot: :environment do
    puts ReTweet.phrase_for_schleep_bot
  end
  
  
  desc "get token"
  task get_oauth_token: :environment do
    
    consumer = OAuth::Consumer.new( ENV['twitter_app_key'], ENV['twitter_app_secret'],
                      {
                          :site => "https://api.twitter.com",
                          :scheme => :header,
                          :http_method => :post,
                          :request_token_path => "/oauth/request_token",
                          :access_token_path => "/oauth/access_token",
                          :authorize_path => "/oauth/authorize"
                      })
    
    reverse_auth_token = ""
    request_token = consumer.get_request_token( {}, 
          {"x_auth_mode" => "reverse_auth"} ) do |response|
      reverse_auth_token = response
    
      #needed because OAuth::Token is expecting a json hash. 
      #But since twitter reverse auth token isn't
      #formatted like that it'll raise and error
      {}
    end
    
    puts "\nReverse Auth Token:"
    puts reverse_auth_token
  end


  
end
