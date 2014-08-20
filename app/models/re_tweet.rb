class ReTweet < ActiveRecord::Base
  
  validates :tweet_id, uniqueness: true
  before_create :yo_me
  
  def self.search_twitter
    
    twitter = Twitter::REST::Client.new do |config|
    
      config.consumer_key = Rails.configuration.consumer_key
      config.consumer_secret = Rails.configuration.consumer_secret
      config.access_token = Rails.configuration.access_token
      config.access_token_secret = Rails.configuration.access_token_secret
      
    end
    
    twitter.search("#wheresmysushi OR #wheresmyburrito OR #wheresmyburger OR #wheresmycheeseburger OR #wheresmypizza -rt", :result_type => "recent", :lang => "en").take(10).each do |tweet|
      thing = tweet.text.downcase.match(/#wheresmy([A-z]*)/)[1]
      self.create({
        :tweet_id => tweet.id,
        :tweeter => tweet.user.screen_name,
        :tweet_text => tweet.text,
        :retweet_text => "#{self.message_choices(thing.downcase)}http://bitchwher.es/#/my/#{thing} RT @#{tweet.user.screen_name}: #{tweet.text}",
        :did_retweet => false
      })
    end
  end
  
  private
    def yo_me
      require "net/http"
      require "uri"
      
      uri = URI.parse("http://api.justyo.co/yo/")
      
      http = Net::HTTP.new(uri.host, uri.port)
      
      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data({"api_token" => Rails.configuration.yo_api_key, "username" => Rails.configuration.yo_username, "link" => "http://afternoon-wildwood-1475.herokuapp.com#{re_tweet_path(self)}"})
      
      http.request(request)
    end
    
    def self.message_choices(thing)
      messages = [
        self.make_retweet_text(thing),
        "I got your #{thing} here: ",
        "Ask and you shall receive "
      ].sample
    end
  
    def self.make_retweet_text(thing)
      case thing
      when "cheeseburger"
        return "Cheese borger, cheese borger, cheese borger! "
      when "burger"
        return "Mmmm burgers... "
      when "burrito"
        return "Tengo tu burrito aqui "
      when "sushi"
        return "Looking for some sushi? "
      when "pizza"
        return "I'm the moon, hitting your eye... "
      else
        return "I got your #{thing} here: "
      end
    end
  
end
